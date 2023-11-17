#!/bin/bash
for file in /home/yourname/project/ncbi/sra/*sra
do
  cat>./raw/fastqd.sh<<EOF
#!/bin/bash
#SBATCH --job-name=fast_dump
#SBATCH --out="slurm-%j.out"
#SBATCH --partition=day
#SBATCH --time=4:00:00
#SBATCH --nodes=1 --ntasks=1 --cpus-per-task=2
#SBATCH --mem-per-cpu=2G
#SBATCH --mail-type=None
fastq-dump -I --gzip --split-files $file
EOF
  sbatch ./raw/fastqd.sh
done


