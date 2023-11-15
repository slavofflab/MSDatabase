#!/bin/bash
#SBATCH --job-name=bamsort
#SBATCH --out="slurm-%j.out"
#SBATCH --partition=day
#SBATCH --time=4:00:00
#SBATCH --nodes=1 --ntasks=1 --cpus-per-task=1
#SBATCH --mem-per-cpu=2G
#SBATCH --mail-type=None
samtools merge ./sort/MCF7_merge.bam ./sort/MCF7_1.sorted.bam ./sort/MCF7_2.sorted.bam ./sort/MCF7_3.sorted.bam
