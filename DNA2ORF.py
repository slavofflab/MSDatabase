#!/usr/bin//env python
## This script can translate transcriptome to all possible ORFs in 3 frame by stop to stop mode.
## Please change the sample name in line 24-26
## "sample_name_Stop_Stop.fasta" merged same peptides and should be used as database
## "sample_name_Stop_Stop_all.fasta" can be used to find all RNA sources of a specific peptide 
## Author: Haomiao Su
## Email: haomiao.su@yale.edu


import argparse
from Bio import SeqIO
from Bio.Seq import Seq
from Bio.SeqRecord import SeqRecord

parser = argparse.ArgumentParser(description='Translate transcriptome to all possible ORFs in 3 frame by stop to stop mode')
parser.add_argument('-i', '--input', dest = 'inputfile', help = 'input DNA/RNA fasta file')
parser.add_argument('-o', '--output', dest = 'outputfile', help = 'input protein fasta file')
args = parser.parse_args()
pep_mini = 20


#input_file = args.inputfile
#output_file = args.outputfile
input_file = "sample_name.fa"
output_file1 = "sample_name_Stop_Stop.fasta"
output_file2 = "sample_name_Stop_Stop_all.fasta"

out_list1,out_list2 = [],[]
pep_col1,pep_col2 = {},{}

for record in SeqIO.parse(input_file, "fasta"):
    for i in range(3):
        pep_list = str(record.seq[i:].translate()).split("*")
        pep_c = 1
        for pep in pep_list:
            if len(pep) >= pep_mini:
                if "K" in pep or "R" in pep:
                    if pep not in pep_col1:
                        pep_col1[pep] = f'{record.id}_{i}_{pep_c}'
                        pep_col2[pep] = f'{record.id}_{i}_{pep_c}'
                        pep_c += 1
                    else:
                        pep_col2[pep] = pep_col2[pep] + f'|{record.id}_{i}_{pep_c}'
                        pep_c += 1

for ps, pid in pep_col1.items():
    out_list1.append(SeqRecord(Seq(ps), id = pid, description = ""))
SeqIO.write(out_list1, output_file1, "fasta")

for ps, pid in pep_col2.items():
    out_list2.append(SeqRecord(Seq(ps), id = pid, description = ""))
SeqIO.write(out_list2, output_file2, "fasta")

