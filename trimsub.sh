#!/bin/bash
mkdir trim
for infile in ./raw/*R1.fastq.gz
do
  outfile=${infile/raw/trim}
  cat>cutadapt.sh<<EOF
#!/bin/bash
#SBATCH --job-name=cutadapt
#SBATCH --out="slurm-%j.out"
#SBATCH --partition=day
#SBATCH --time=2:00:00
#SBATCH --nodes=1 --ntasks=1 --cpus-per-task=2
#SBATCH --mem-per-cpu=1G
#SBATCH --mail-type=None
cutadapt -a AGATCGGAAGAGCACACGTCTGAACTCCAGTCA -A AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT -m 18 -o ${outfile/fastq.gz/trimmed.fastq.gz} -p ${outfile/R1.fastq.gz/R2.trimmed.fastq.gz} $infile ${infile/R1.fastq.gz/R2.fastq.gz}
EOF
  sbatch cutadapt.sh
done
#Here we used Illumina Universal Adapters
#More adpater sequence can be found at https://dnatech.genomecenter.ucdavis.edu/wp-content/uploads/2019/03/illumina-adapter-sequences-2019-1000000002694-10.pdf
