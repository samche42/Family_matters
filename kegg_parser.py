#This script can be used to count the number of times a particluar set of KO entries 
#appears in n genomes. List of KOs needs one KO entry per line and output from kofamscan. 
#Script will output KO counts in a table. Example KO list in git repo "master_list"

#Usage: python3 kegg_parser.py path/to/kofamsccan/output master_list

import os
import sys
from csv import DictWriter

input_directory = sys.argv[1]

query = sys.argv[2] #Custom list of KOs to be checked
query_list = []
with open(os.path.join(input_directory, query)) as query_input:
        for line in query_input:
                query_list.append(line.strip("\n"))

#create list of kegg files to parse through
kegg_files = [file for file in os.listdir(input_directory) if file.endswith("kegg_output")]

#create dictionary to store genome kegg annotations
kegg_annotations = {}
ko_list = []
#Create a dictionary for each genome, with all query KOs set to a count of 0.
for kegg in kegg_files:
        ko_entries = []
        genome_dict = {"Genome": str(kegg)}
        for ko in query_list:
                genome_dict[ko] = 0
#Parse through each kofamscan_outputfile per genome
        with open(os.path.join(input_directory, kegg)) as input:
                for line in input:
                        if len(line.split("\t")) == 1: #if there is no KO annotation for this gene, ignore it
                                pass
                        else:
                                gene, ko = line.strip("\n").split("\t")
                                ko_entries.append(ko) #Add KO to list
        input.close()
        for ko_entry in ko_entries:
                if ko_entry in genome_dict:
                        genome_dict[ko_entry] += 1
                else:
                        pass
        ko_list.append(dict(genome_dict)) #Append new dictionary to overall list

#Write it out to a file
keys = ko_list[0].keys()
with open((os.path.join(input_directory,"KEGG_output_count_table.txt")),"w") as output:
        dict_writer = DictWriter(output, keys, delimiter = "\t")
        dict_writer.writeheader()
        for item in ko_list:
                dict_writer.writerow(item)
output.close()
