#!/bin/bash
#SBATCH --job-name=index
#SBATCH --out="slurm-%j.out"
#SBATCH --partition=day
#SBATCH --time=1:00:00
#SBATCH --nodes=1 --ntasks=1 --cpus-per-task=8
#SBATCH --mem-per-cpu=2G
#SBATCH --mail-type=None
samtools index -@ 8 ./sort/input.sorted.bam
