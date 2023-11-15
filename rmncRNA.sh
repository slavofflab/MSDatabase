#!/bin/bash
#SBATCH --job-name=removencRNA
#SBATCH --out="slurm-%j.out"
#SBATCH --partition=day
#SBATCH --time=4:00:00
#SBATCH --nodes=1 --ntasks=1 --cpus-per-task=8
#SBATCH --mem-per-cpu=5G
#SBATCH --mail-type=None
STAR --runThreadN 8 --genomeDir ~/project/stargenome/ncrna_idx --genomeLoad LoadAndRemove --readFilesIn ./trim/MCF7_2_R1.trimmed.fastq.gz ./trim/MCF7_2_R2.trimmed.fastq.gz --readFilesCommand zcat --outFileNamePrefix ./rmncrna/MCF7_2. --outFilterIntronMotifs RemoveNoncanonical --outStd BAM_Unsorted --outSAMtype BAM Unsorted --outFilterType BySJout --outReadsUnmapped Fastx --outSAMattributes All --outSAMattrRGline ID:su > /dev/null

