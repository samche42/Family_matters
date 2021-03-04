import sys
import os
from glob import glob
from Bio import SeqIO

wanted =[]

input_directory = sys.argv[1]
#directory is path to orthologous group files
nucleotide_file = sys.argv[2]
#nucleotide_file is path the conactenated nucleotide file corresponding to proteins

protein_file_list = [os.path.abspath(fn) for fn in glob(input_directory+'/*.fa')]
#creation of list that hold fullpath to each OG file to be parsed

for OG_group in protein_file_list:
        output_file = os.path.abspath(OG_group).split(".")[0]+"_nuc.fasta"
        #outputfile named the same as input OG file
        wanted = list(r.id for r in SeqIO.parse(OG_group, "fasta"))
        #lists all headers in OG file
        records = (r for r in SeqIO.parse(nucleotide_file, "fasta") if r.id in wanted)
        #pulls all fastas with headers that correspond to wanted list
        SeqIO.write(records, output_file, "fasta")
        #writes pulled fastas to output files
