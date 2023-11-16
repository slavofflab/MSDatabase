#!/usr/bin/python
## This script can translate transcriptome to all possible ORFs in 3 frame by start to stop modle.
## Author: Haomiao Su
## Email: haomiao.su@yale.edu

import argparse
from Bio import SeqIO
from Bio.Seq import Seq
from Bio.SeqRecord import SeqRecord
import re
import warnings

def start_pos(nseq, it):
    nseq = str(nseq)
    ls = len(nseq)//3
    start_p = ""
    for j in range(ls):
        start_p += it[nseq[3*j:3*j+3]]
    return start_p

parser = argparse.ArgumentParser(description='Translate transcriptome to all possible ORFs in 3 frame by stop to stop modle')
parser.add_argument('-i', '--input', dest = 'inputfile', help = 'input DNA/RNA fasta file')
parser.add_argument('-o', '--output', dest = 'outputfile', help = 'input protein fasta file')
args = parser.parse_args()
pep_mini = 5

ini_table = {}
dna_letters = ["A", "T", "C", "G"]
for N1 in dna_letters:
    for N2 in dna_letters:
        for N3 in dna_letters:
            ini_table[N1+N2+N3] = "P"
ini_table["ATG"], ini_table["CTG"], ini_table["GTG"], ini_table["TAA"], ini_table["TAG"], ini_table["TGA"] = "M", "M", "M", "*", "*", "*"
ini_table["TTG"] = "M"
#ini_table["TTG"], ini_table["ACG"], ini_table["ATC"], ini_table["ATT"], ini_table["AAG"], ini_table["ATA"],= "M", "M", "M", "M", "M", "M"

#input_file = args.inputfile
#output_file = args.outputfile
input_file = "sample.fa"
output_file = "sample_Start_Stop.fasta"

out_list = []
pep_col = {}

for record in SeqIO.parse(input_file, "fasta"):
    for i in range(3):
        tem_trans = record.upper().seq[i:]
        if  "N" in tem_trans:
            pass
        else:
            tem_pep = "*" + str(tem_trans.translate())
            ini_seq = "*" + start_pos(tem_trans, ini_table)
            end_sites = [m.start() + 1 for m in re.finditer("\\*",tem_pep)]
            n = len(end_sites)
            pep_c = 1
            for k in range(n-1):
                pep_f = str(tem_pep[end_sites[k]:end_sites[k+1]])
                ini_f = str(ini_seq[end_sites[k]:end_sites[k+1]])
                if "M" in ini_f:
                    peptide = pep_f[ini_f.index("M"):-1]
                    L = len(peptide)
                    if L >= pep_mini:
                        if peptide not in pep_col:
                            pep_col[peptide] = f'{record.id}_{i}_{pep_c}'
                            pep_c += 1
                        else:
#                            pep_col[peptide] = pep_col[peptide] + f'|{record.id}_{i}_{pep_c}'
                            pep_c += 1

for ps, pid in pep_col.items():
    out_list.append(SeqRecord(Seq(ps), id = pid, description = ""))
                
SeqIO.write(out_list, output_file, "fasta")
