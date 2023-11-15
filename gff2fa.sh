#!/bin/bash
#SBATCH --job-name=cufflinks
#SBATCH --out="slurm-%j.out"
#SBATCH --partition=day
#SBATCH --time=2:00:00
#SBATCH --nodes=1 --ntasks=1 --cpus-per-task=1
#SBATCH --mem-per-cpu=5G
#SBATCH --mail-type=None
gffread ./asemble/MCF7/MCF7.gtf -g ~/project/stargenome/pri_hg38.fa -w MCF7.fa
