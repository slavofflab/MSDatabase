#!/bin/bash
mkdir raw
for file in /home/hs848/project/ncbi/sra/*sra
do
  cat>./raw/fastqd.sh<<EOF
#!/bin/bash
#SBATCH --job-name=fastq_dump
#SBATCH --out="slurm-%j.out"
#SBATCH --partition=day
#SBATCH --time=4:00:00
#SBATCH --nodes=1 --ntasks=1 --cpus-per-task=2
#SBATCH --mem-per-cpu=2G
#SBATCH --mail-type=None
fastq-dump -I --gzip --split-files -O ~/palmer_scratch/mRNA/raw $file
EOF
  sbatch ./raw/fastqd.sh
done
