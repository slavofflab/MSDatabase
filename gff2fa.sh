#!/bin/bash
#SBATCH --job-name=gff2fa
#SBATCH --out="slurm-%j.out"
#SBATCH --partition=day
#SBATCH --time=2:00:00
#SBATCH --nodes=1 --ntasks=1 --cpus-per-task=1
#SBATCH --mem-per-cpu=5G
#SBATCH --mail-type=None
gffread ./asemble/genome/annotation.gtf -g ~/project/stargenome/genome.fa -w sample.fa
