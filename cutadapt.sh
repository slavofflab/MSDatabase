#!/bin/bash
#SBATCH --job-name=cutadapt
#SBATCH --out="slurm-%j.out"
#SBATCH --partition=day
#SBATCH --time=2:00:00
#SBATCH --nodes=1 --ntasks=1 --cpus-per-task=2
#SBATCH --mem-per-cpu=1G
#SBATCH --mail-type=None
cutadapt -a AGATCGGAAGAGCACACGTCTGAACTCCAGTCA -A AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT -m 18 -o ./trim/output_R1.trimmed.fastq.gz -p ./trim/output_R2.trimmed.fastq.gz ./raw/input_R1.fastq.gz ./raw/input_R2.fastq.gz
#Here we used Illumina Universal Adapters
#More adapter sequences can be found at https://dnatech.genomecenter.ucdavis.edu/wp-content/uploads/2019/03/illumina-adapter-sequences-2019-1000000002694-10.pdf
