#!/bin/bash
#SBATCH --job-name=cutadapt
#SBATCH --out="slurm-%j.out"
#SBATCH --partition=day
#SBATCH --time=2:00:00
#SBATCH --nodes=1 --ntasks=1 --cpus-per-task=2
#SBATCH --mem-per-cpu=1G
#SBATCH --mail-type=None
cutadapt -a AGATCGGAAGAGCACACGTCTGAACTCCAGTCA -A AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT -m 18 -o ./trim/MCF7_3_R1.trimmed.fastq.gz -p ./trim/MCF7_3_R2.trimmed.fastq.gz ./raw/MCF7_3_R1.fastq.gz ./raw/MCF7_3_R2.fastq.gz
