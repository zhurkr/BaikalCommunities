#usearch = usearch v10.0.240_i86linux32
#Sort zOTU in table
./usearch -otutab_sortotus ./updated_BD.zotutab_filtr.txt -output BD.zotutab_filtr_sorted.txt

#Statistics
cd ./usearch -otutab_stats ./updated_BD.zotutab_filtr.txt -output BD.z_report.txt

#Taxonomy summary reports
./usearch -sintax_summary updated_BD.z_sintax_filtr.txt -otutabin updated_BD.zotutab_filtr.txt -rank p -output BD.z_phylum_summary.txt
./usearch -sintax_summary updated_BD.z_sintax_filtr.txt -otutabin updated_BD.zotutab_filtr.txt -rank c -output BD.z_class_summary.txt
./usearch -sintax_summary updated_BD.z_sintax_filtr.txt -otutabin updated_BD.zotutab_filtr.txt -rank o -output BD.z_order_summary.txt
./usearch -sintax_summary updated_BD.z_sintax_filtr.txt -otutabin updated_BD.zotutab_filtr.txt -rank f -output BD.z_family_summary.txt
./usearch -sintax_summary updated_BD.z_sintax_filtr.txt -otutabin updated_BD.zotutab_filtr.txt -rank g -output BD.z_genus_summary.txt

#Warning: 
#If you have a message like this "Line 737 has 3 fields (need 4)" indicates that line 737 of your #BD.z_sintax_filtr.txt file contains only 3 fields instead of the expected 4. To fix this error, #you need to edit this line and add the missing field. You can use any text editor or command-line #tools to make this correction. Than do taxonomy summary reports.

