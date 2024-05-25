# if (!requireNamespace("BiocManager", quietly = TRUE))
#  install.packages("BiocManager")
# BiocManager::install("dada2")
# BiocManager::install("phyloseq")
# BiocManager::install("Biostrings")

library(dada2); packageVersion("dada2")
library(tidyverse)
library(phyloseq); packageVersion("phyloseq")
library(Biostrings); packageVersion("Biostrings")
library(ggplot2); packageVersion("ggplot2")
library(readxl)

path <- getwd()
list.files(path)

# Forward and reverse fastq filenames have format: SAMPLENAME_R1_001.fastq and SAMPLENAME_R2_001.fastq
fnFs <- sort(list.files(path, pattern="_R1_001.fastq", full.names = TRUE))
fnRs <- sort(list.files(path, pattern="_R2_001.fastq", full.names = TRUE))
# Extract sample names, assuming filenames have format: SAMPLENAME_XXX.fastq
sample.names <- sapply(strsplit(basename(fnFs), "_"), `[`, 1)
sample.names
# We start by visualizing the quality profiles of the forward reads:

plotQualityProfile(fnFs[1:2])


# Now we visualize the quality profile of the reverse reads:

plotQualityProfile(fnRs[1:2])

### Filter and trim

# Place filtered files in filtered/ subdirectory
filtFs <- file.path(path, "filtered", paste0(sample.names, "_F_filt.fastq.gz"))
filtRs <- file.path(path, "filtered", paste0(sample.names, "_R_filt.fastq.gz"))

out <- filterAndTrim(fnFs, filtFs, fnRs, filtRs, truncLen=c(275,275),
                     maxN=0, maxEE=c(1,1), truncQ=2, rm.phix=TRUE, 
                     trimLeft = c(20,15), compress=TRUE, multithread=FALSE) 
# On Windows set multithread=FALSE
head(out)


### Learn the Error Rates

# Calculate error rates
errF <- learnErrors(filtFs, multithread=TRUE)

errR <- learnErrors(filtRs, multithread=TRUE)

# Visualize the estimated error rates:
plotErrors(errF, nominalQ=TRUE)

### Dereplication
# Dereplication combines all identical sequencing reads into into 
# “unique sequences” with a corresponding “abundance” equal to the 
# number of reads with that unique sequence. 

derepFs <- derepFastq(filtFs, verbose=TRUE)
derepRs <- derepFastq(filtRs, verbose=TRUE)
# Name the derep-class objects by the sample names
names(derepFs) <- sample.names
names(derepRs) <- sample.names

### Sample Inference

# Apply the core sample inference algorithm to the dereplicated data.

dadaFs <- dada(derepFs, err=errF, multithread=TRUE)

dadaRs <- dada(derepRs, err=errR, multithread=TRUE)

dadaFs[[1]]

### Merge paired reads

mergers <- mergePairs(dadaFs, derepFs, dadaRs, derepRs, verbose=TRUE)
# Inspect the merger data.frame from the first sample
head(mergers[[1]])

### Construct sequence table

# We can now construct an amplicon sequence variant table (ASV) table

seqtab <- makeSequenceTable(mergers)

dim(seqtab)

# Inspect distribution of sequence lengths
table(nchar(getSequences(seqtab)))

### Remove chimeras

seqtab.nochim <- removeBimeraDenovo(seqtab, method="consensus", multithread=TRUE, verbose=TRUE)
dim(seqtab.nochim)

#
sum(seqtab.nochim)/sum(seqtab)

### Track reads through the pipeline
getN <- function(x) sum(getUniques(x))
track <- cbind(out, sapply(dadaFs, getN), sapply(dadaRs, getN), sapply(mergers, getN), rowSums(seqtab.nochim))
# If processing a single sample, remove the sapply calls: e.g. replace sapply(dadaFs, getN) with getN(dadaFs)
colnames(track) <- c("input", "filtered", "denoisedF", "denoisedR", "merged", "nonchim")
rownames(track) <- sample.names
head(track)

### Assign taxonomy
taxa <- assignTaxonomy(seqtab.nochim, "silva_nr_v132_train_set.fa", multithread=TRUE)
# taxa_132 <- assignTaxonomy(seqtab.nochim, "silva_nr_v132_train_set.fa", multithread=TRUE)
### inspect the taxonomic assignments:

taxa.print <- taxa # Removing sequence rownames for display only
rownames(taxa.print) <- NULL
head(taxa.print)

samples.out <- rownames(seqtab.nochim)

metadata <- read_xlsx("Metadata_Varnachka_new.xlsx", sheet="18S")

samdf <- as.data.frame(metadata)

rownames(samdf) <- samdf$Sample
ps <- phyloseq(otu_table(seqtab.nochim, taxa_are_rows=FALSE), 
               sample_data(samdf), 
               tax_table(taxa))

dna <- Biostrings::DNAStringSet(taxa_names(ps))
names(dna) <- taxa_names(ps)
ps <- merge_phyloseq(ps, dna)
taxa_names(ps) <- paste0("ASV", seq(ntaxa(ps)))
ps

ps_na <- subset_taxa(ps, (tax_table(ps)[,"Phylum"]!="Arthropoda") | is.na(tax_table(ps)[,"Phylum"]))
ps_na
