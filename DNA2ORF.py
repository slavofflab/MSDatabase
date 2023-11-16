#!/usr/bin//env python
## This script can translate transcriptome to all possible ORFs in 3 frame by stop to stop modle.
## Author: Haomiao Su
## Email: haomiao.su@yale.edu


import argparse
from Bio import SeqIO
from Bio.Seq import Seq
from Bio.SeqRecord import SeqRecord

parser = argparse.ArgumentParser(description='Translate transcriptome to all possible ORFs in 3 frame by stop to stop modle')
parser.add_argument('-i', '--input', dest = 'inputfile', help = 'input DNA/RNA fasta file')
parser.add_argument('-o', '--output', dest = 'outputfile', help = 'input protein fasta file')
args = parser.parse_args()


#input_file = args.inputfile
#output_file = args.outputfile
input_file = "ERVKMAP.fa"
output_file = "ERVKMAP_Stop_Stop.fasta"

out_list = []
pep_col = {}

for record in SeqIO.parse(input_file, "fasta"):
    for i in range(3):
        pep_list = str(record.seq[i:].translate()).split("*")
        pep_c = 1
        for pep in pep_list:
            if len(pep)>5:
                if pep not in pep_col:
                    pep_col[pep] = f'{record.id}_{i}_{pep_c}'
                    pep_c += 1
                else:
#                    pep_col[pep] = pep_col[pep] + f'|{record.id}_{i}_{pep_c}'
                    pep_c += 1

for ps, pid in pep_col.items():
    out_list.append(SeqRecord(Seq(ps), id = pid, description = ""))
SeqIO.write(out_list, output_file, "fasta")
