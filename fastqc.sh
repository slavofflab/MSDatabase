#!/bin/bash
#SBATCH --job-name=fastq_dump
#SBATCH --out="slurm-%j.out"
#SBATCH --partition=day
#SBATCH --time=1:00:00
#SBATCH --nodes=1 --ntasks=1 --cpus-per-task=1
#SBATCH --mem-per-cpu=1G
#SBATCH --mail-type=None
fastqc ./raw/input_R2.fastq.gz
