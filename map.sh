#!/bin/bash
#SBATCH --job-name=readmapping
#SBATCH --out="slurm-%j.out"
#SBATCH --partition=day
#SBATCH --time=4:00:00
#SBATCH --nodes=1 --ntasks=1 --cpus-per-task=16
#SBATCH --mem-per-cpu=3G
#SBATCH --mail-type=None
STAR --runThreadN 16 --genomeDir ~/project/stargenome/hg38_idx --genomeLoad LoadAndRemove --readFilesIn ./rmncrna/input.Unmapped.out.mate1 ./rmncrna/input.Unmapped.out.mate2 --outFileNamePrefix ./map/input. --outFilterIntronMotifs RemoveNoncanonical --outStd BAM_Unsorted --outSAMtype BAM Unsorted --outFilterType BySJout --outReadsUnmapped Fastx --outSAMattributes All --outSAMstrandField intronMotif > ./map/input.mapped.bam

