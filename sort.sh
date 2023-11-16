#!/bin/bash
#SBATCH --job-name=bamsort
#SBATCH --out="slurm-%j.out"
#SBATCH --partition=day
#SBATCH --time=4:00:00
#SBATCH --nodes=1 --ntasks=1 --cpus-per-task=1
#SBATCH --mem-per-cpu=2G
#SBATCH --mail-type=None
samtools sort -o ./sort/output.sorted.bam ./map/input.mapped.bam
