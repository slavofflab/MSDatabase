#!/bin/bash
#SBATCH --job-name=stringTie
#SBATCH --out="slurm-%j.out"
#SBATCH --partition=day
#SBATCH --time=24:00:00
#SBATCH --nodes=1 --ntasks=1 --cpus-per-task=32
#SBATCH --mem-per-cpu=3G
#SBATCH --mail-type=None
stringtie -p 32 -v --fr -o ./asemble/HEK293T/StringTie.gtf -G ~/project/stargenome/gencode.v38.annotation.gtf -l MCF7_ST ./sort/MCF7.sorted.bam
