#!/bin/bash
for file in ./raw/*.fastq.gz
do
  cat>fastqc.sh<<EOF
#!/bin/bash
#SBATCH --job-name=fastqc
#SBATCH --out="slurm-%j.out"
#SBATCH --partition=day
#SBATCH --time=1:00:00
#SBATCH --nodes=1 --ntasks=1 --cpus-per-task=1
#SBATCH --mem-per-cpu=1G
#SBATCH --mail-type=None
fastqc $file
EOF
  sbatch fastqc.sh
done


