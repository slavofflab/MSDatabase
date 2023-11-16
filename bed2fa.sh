#!/bin/bash
#SBATCH --job-name=bedtofasta
#SBATCH --out="slurm-%j.out"
#SBATCH --partition=day
#SBATCH --time=2:00:00
#SBATCH --nodes=1 --ntasks=1 --cpus-per-task=1
#SBATCH --mem-per-cpu=5G
#SBATCH --mail-type=None
bedtools getfasta -fi ~/project/stargenome/genome.fa -bed ./asemble/samplename/filename.bed  -s -nameOnly > filename.fa
