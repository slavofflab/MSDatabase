#!/bin/bash
#SBATCH --job-name=readmapping
#SBATCH --out="slurm-%j.out"
#SBATCH --partition=day
#SBATCH --time=4:00:00
#SBATCH --nodes=1 --ntasks=1 --cpus-per-task=16
#SBATCH --mem-per-cpu=3G
#SBATCH --mail-type=None
STAR --runThreadN 16 --genomeDir ~/project/stargenome/hg38_idx --genomeLoad LoadAndRemove --readFilesIn ./rmncrna/MCF7_3.Unmapped.out.mate1 ./rmncrna/MCF7_3.Unmapped.out.mate2 --outFileNamePrefix ./map/MCF7_3. --outFilterIntronMotifs RemoveNoncanonical --outStd BAM_Unsorted --outSAMtype BAM Unsorted --outFilterType BySJout --outReadsUnmapped Fastx --outSAMattributes All --outSAMstrandField intronMotif > ./map/MCF7_3.mapped.bam

