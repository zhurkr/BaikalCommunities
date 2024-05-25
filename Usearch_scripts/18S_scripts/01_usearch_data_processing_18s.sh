#usearch = usearch v10.0.240_i86linux32

#Rename samples
for file in Irkutsk-Bash-18s-*.fastq; do
    mv "$file" "${file#Irkutsk-Bash-18s-}"
done

#Merge paired reads
./usearch11.0.667_i86linux32 -fastq_mergepairs ./*R1*_001.fastq -fastqout BD.merged.fq -relabel @

#Strip primers (F is 21, R is 20)
./usearch11.0.667_i86linux32 -fastx_truncate ./BD.merged.fq -stripleft 21 -stripright 20 -fastqout BD.stripped.fq

#Quality filter
./usearch11.0.667_i86linux32 -fastq_filter ./BD.stripped.fq -fastq_maxee 1.0 -fastq_minlen 275 -fastaout BD.filtered.fa

#Find unique read sequences and abundances 
./usearch11.0.667_i86linux32 -fastx_uniques ./BD.filtered.fa -sizeout -relabel Uniq -fastaout BD.uniques.fa

#Denoise: predict biological sequences and filter chimeras 
./usearch11.0.667_i86linux32 -unoise3 ./BD.uniques.fa -zotus BD.zotus.fa

#Make zOTU table
./usearch11.0.667_i86linux32 -otutab ./BD.stripped.fq -otus BD.zotus.fa -otutabout BD.zotutab.txt

#Predict taxonomy
./usearch11.0.667_i86linux32 -sintax ./BD.zotus.fa -db ./silva_nr_v132_train_set_usearch_SINTAX_compatible.fa -strand plus -tabbedout BD.z_sintax.txt -sintax_cutoff 0.8

#Removing Metazoa from the BD.zotus.fa, BD.z_sintax.txt and BD.zotutab.txt files using log_metazoa_script (in R language). Then carry out further analysis.

#Warning: after processing the BD.zotutab.txt with log_metazoa_script, it is necessary to rename #the first column in the filtered BD.zotutab_filtr.txt from X.OTU.ID to OTU.ID for further #analysis.

#Check the taxonomy of the first 20 zOTUs with BLAST and remove zOTUs with low confidence in the #taxonomy definition using zOTU_removing_script_18s (in this step you will get #updated_BD.zotutab_filtr.txt, updated_BD.z_sintax_filtr.txt and updated_BD.zotus_filtr.fa" #without zOTUs with low confidence in the taxonomy definition)