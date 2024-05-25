#usearch = usearch v10.0.240_i86linux32

#Sort zOTU in table
./usearch11.0.667_i86linux32 -otutab_sortotus ./BD.zotutab_filtr.txt -output BD.zotutab_filtr_sorted.txt

# Statistics
./usearch11.0.667_i86linux32 -otutab_stats ./BD.zotutab_filtr_sorted.txt -output BD.z_report.txt


#Taxonomy summary reports
./usearch11.0.667_i86linux32 -sintax_summary BD.z_sintax_filtr.txt -otutabin BD.zotutab_filtr_sorted.txt  -rank p -output BD.z_phylum_summary.txt
./usearch11.0.667_i86linux32 -sintax_summary BD.z_sintax_filtr.txt -otutabin BD.zotutab_filtr_sorted.txt  -rank c -output BD.z_class_summary.txt
./usearch11.0.667_i86linux32 -sintax_summary BD.z_sintax_filtr.txt -otutabin BD.zotutab_filtr_sorted.txt  -rank o -output BD.z_order_summary.txt
./usearch11.0.667_i86linux32 -sintax_summary BD.z_sintax_filtr.txt -otutabin BD.zotutab_filtr_sorted.txt  -rank f -output BD.z_family_summary.txt
./usearch11.0.667_i86linux32 -sintax_summary BD.z_sintax_filtr.txt -otutabin BD.zotutab_filtr_sorted.txt  -rank g -output BD.z_genus_summary.txt

#Warning: 
#If you have a message like this "Line 737 has 3 fields (need 4)" indicates that line 737 of your #BD.z_sintax_filtr.txt file contains only 3 fields instead of the expected 4. To fix this error, #you need to edit this line and add the missing field. You can use any text editor or command-line #tools to make this correction. Than do taxonomy summary reports.



