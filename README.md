# BaikalCommunities
This is the github repository along our project  'Comparative analysis of free-living (FL) and particle-associated (PA) bacterial communities in the photic layer of Lake Baikal using rRNA metabarcoding".


> Scripts

All scripts are located in the `Usearch_scripts` and `DADA2_scripts` folders.

> Illustrations

The images for illustrating the repositry's readme files are located in the `illustrations` folder.


## Introduction

Lake Baikal is an oligotrophic water body with low concentration of nutrients. During the ice period, the upper layer of water near the bottom surface of the ice is increasingly enriched with nutrients due to salting out processes (doi:10.1080/03680770.1998.11898179) which promotes the development of microorganisms. The goal of the project is to identify similarities and differences in communities of bacteria and microeukaryotes living on the bottom surface of the ice and water column of Lake Baikal using metabarcoding of 16S and 18S rRNA gene fragments. 

## Aims

Identify seasonal changes in biodiversity and structure of FL and PA bacterial communities

## Tasks

1. Compare the results of sequencing data processing using two pipelines USEARCH10/11 and DADA2;
2. Data processing: read merging, primer trimming, high-quality filtering, removal of mitochondrial, chloroplast and unknown reads;
3. Obtaining data on the taxonomic structure and biodiversity of bacterial and microeukaryotic communities.


(rdp_16s_v18)
(silva_nr_v132)

## Data
Instrument: Illumina MiSeq
Strategy: AMPLICON
Source: METAGENOMIC
Selection: PCR
Layout: PAIRED

We have analyzed FL and PA bacteria and microeukaryotic community composition of PA samples from the photic layer of Lake Baikal. The samples were taken from various depths, distances from the shore and seasons. For 37 bacterial community samples a total of 307,100 reads were produced and 185,600 reads for 20 microeukaryotic community. Six samples (V1PL-7-PA, V2UI-10-FL, V2UI-5-PA, V2UI-10-PA, V3UI-5-PA and UW2/30_5) were excluded from further analysis, due to a low coverage. Rarefaction curves suggested that the sequencing effort was enough to estimate the community diversity, although the analysis of PA bacterial communities could benefit from further sequencing.

Data is available
Metadata are situated in the `data` folder.

### Workflow plan

##### Usearch+vegan pipeline

1. ```usearch_data_processing_part_1``` - data processing: read merging, primer trimming, high-quality filtering, finding unique read, predicting biological sequences, filtering chimeras, making zOTU table, taxonomy prediction, removal of mitochondrial, chloroplast and unknown reads;

2. ```log_chloroplast_script``` - removing chloroplasts and mitochondria from the BD.zotus.fa, BD.z_sintax.txt and BD.zotutab.txt files (in R language). Then carry out further analysis;

Warning: after processing the BD.zotutab.txt with log_chloroplast_script, it is necessary to rename the first column in the filtered BD.zotutab_filtr.txt from X.OTU.ID to OTU.ID for further analysis;

3. ```zOTU_removing_script``` - check the taxonomy of the first 20 zOTUs with BLAST and remove zOTUs with low confidence in the taxonomy definition using zOTU_removing_script (in this step you will get updated_BD.zotutab_filtr.txt, updated_BD.z_sintax_filtr.txt and updated_BD.zotus_filtr.fa" without zOTUs with low confidence in the taxonomy definition)

4. ```usearch_data_processing_part_2``` - taxonomy summary reports and statistics report generation
5. ```rarecurve_script``` - generate rarefaction curves for the PA data
6. ```NMDS_plot_script``` - construction NMDS plot
7. ```alpha_diversity_script``` - species diversity assessment
8. ```boxplot_script``` - visualization of species diversity assessment
9. ```phylum_relative_abundance_script_275_combi``` - visualisation of relative abundance at the phylum level
10.```class_relative_abundance_script_275_combi``` -  visualisation of relative abundance at the classes level
11.```genus_relative_abundance_script_275_combi``` - visualisation of relative abundance at the genus level


## Results and discussion

Results obtained with USEARCH10/11 and DADA2 are different (mostly in richness and biodiversity). Abundance estimation results are similar for the two approaches. USEARCH-UNOISE3 showed higher sensitivity. DADA2 showed higher biological resolution


## Literature

1. Bashenkhaeva, M.; Yeletskaya, Y.; Tomberg, I.; Marchenkov, A.; Titova, L.; Galachyants, Y. Free-Living and Particle-Associated Microbial Communities of Lake Baikal Differ by Season and Nutrient Intake. Diversity 2023, 15, 572. https://doi.org/10.3390/d15040572.
2.Bukin YS, Mikhailov IS, Petrova DP, Galachyants YP, Zakharova YR, Likhoshway YV. The effect of metabarcoding 18S rRNA region choice on diversity of microeukaryotes including phytoplankton. World J Microbiol Biotechnol. 2023 Jun 21;39(9):229. doi: 10.1007/s11274-023-03678-1. PMID: 37341802.
3.Mikhailov, I.S., Galachyants, Y.P., Bukin, Y.S. et al. Seasonal Succession and Coherence Among Bacteria and Microeukaryotes in Lake Baikal. Microb Ecol 84, 404–422 (2022). https://doi.org/10.1007/s00248-021-01860-2.
4.Prodan A, Tremaroli V, Brolin H, Zwinderman AH, Nieuwdorp M, Levin E. Comparing bioinformatic pipelines for microbial 16S rRNA amplicon sequencing. PLoS One. 2020 Jan 16;15(1):e0227434. doi: 10.1371/journal.pone.0227434.

## Authors

 - Kristina Zhur, 
 - Aleksei Sivtsev
 - Maria Bashenkhaeva* (Limnological Institute SB RAS, Irkutsk State University)
 - Polina Drozdova* (Limnological Institute SB RAS, Irkutsk State University)

\* project supervisor 

## Feedback

You can write us about any problems or ideas about project improvements on telegram @ZhurKristina 
