#!/bin/bash
#SBATCH --job-name=bammerge
#SBATCH --out="slurm-%j.out"
#SBATCH --partition=day
#SBATCH --time=4:00:00
#SBATCH --nodes=1 --ntasks=1 --cpus-per-task=1
#SBATCH --mem-per-cpu=2G
#SBATCH --mail-type=None
samtools merge ./sort/output_merge.bam ./sort/input_1.sorted.bam ./sort/input_2.sorted.bam ./sort/input_3.sorted.bam
#List all bam file here
