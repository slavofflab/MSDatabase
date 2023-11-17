#!/usr/bin/env python
## Slavoff Lab
## This script can filter Mascot results with annotated database(s) to get unannotated proteins.
## Author: Haomiao Su
## Email: haomiao.su@yale.edu

import csv
import re
import time
import tracemalloc
from Bio import SeqIO
from Bio.Seq import Seq
from Bio.SeqRecord import SeqRecord

startTime = time.time()
tracemalloc.start()

#Input file name
infile = "input.csv"
outfile = infile.replace(".csv", "_fi.csv")
#score filter, this should be changed based on Mascot score distrubution
sf = 37
#select True if want to filter with targe database, or select False
dbfilter = True

print("Start loading peptides")
peplist,scorelist,qlist = {},{},{}
with open(infile) as csvfile:
    msresult = csv.reader(csvfile)
    next(msresult)
    for line in msresult:
        pep = line[24]
        score = float(line[21])
        query = line[10]
        Flag = False
        if score < sf:
            pass
        else:            
#Change number after "==" to unannotated database number in Mascot search
            if line[2][0] == "3" or line[2][0] == "4":
                Flag = True
            if pep in peplist:
                if not Flag:
                    peplist[pep][0] = Flag
                peplist[pep][1].append(query)
            else:
                peplist[pep] = [Flag,[query]]
            if query in qlist:
                if pep not in qlist[query]:
                    qlist[query].append(pep)
            else:
                qlist[query]=[pep]
            
l1 = len(peplist)
print(f"Finish loading {l1} peptides")

peplist2 = []

i = 1
for pep, inf in peplist.items():
    if i%100 == 0:
        print(f"{i} peptides done")
    Flag = inf[0]
    if Flag:
        for q in inf[1]:
            if len(qlist[q]) > 1:
                Flag =False
    if Flag:
        peplist2.append(pep)
    i += 1

l2 = len(peplist2)                
print(f"Found {l2} potential peptides")                

peplist3 = []
if dbfilter:
    print("Start loading proteins")
    prolist = []
#Full path to annotated database. NCBI database recommended
    profile = "E:/DataBase/NCBI_GRCh38_latest_protein.fasta"
    for record in SeqIO.parse(profile,"fasta"):
        prolist.append("_" + str(record.seq) + "@")
    l3 = len(prolist)
    print(f"Finish loading {l3} proteins")
    print("Start removing peptides showed in target database")

    j = 0
    for pep in peplist2:
        Tag = True
        j += 1
        if j%10 == 0:
            print(f"{j} peptides done")
        if pep[-1] == "K" or pep[-1] == "R":
            p = re.compile(r"(_M|[_KR])"+ pep + "[^P]")
        else:
            p = re.compile(r"(_M|[_KR])"+ pep + "@")
        for pro in prolist:
            if re.search(p,pro):
                Tag = False
                break
        if Tag:
            peplist3.append(pep)


    print("Analysis finished")
    print(f"Get {j} novel peptides")

else:
    peplist3 = peplist2

print("Write result file")

csvfile2 = open(outfile, "w", newline = "")
final = csv.writer(csvfile2)
with open(infile) as csvfile:
    msresult = csv.reader(csvfile)
    header = next(msresult)
    final.writerow(header)
    for line in msresult:
        if line[24] in peplist3 and line[10] in qlist:
            final.writerow(line)

csvfile2.close()            
                
#print(peplist)
#print(prolist)
print(tracemalloc.get_traced_memory())
tracemalloc.stop()
executionTime = (time.time() - startTime)
print('Execution time in seconds: ' + str(executionTime))    
