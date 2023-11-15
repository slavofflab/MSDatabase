#!/bin/bash
mkdir rmncrna
for infile in ./trim/*R1.trimmed.fastq.gz
do
  outfile=${infile/trim/rmncrna}
  outfile=${outfile/_R1.trimmed.fastq.gz/.}
  cat>rmncRNA.sh<<EOF
#!/bin/bash
#SBATCH --job-name=removencRNA
#SBATCH --out="slurm-%j.out"
#SBATCH --partition=day
#SBATCH --time=4:00:00
#SBATCH --nodes=1 --ntasks=1 --cpus-per-task=4
#SBATCH --mem-per-cpu=1G
#SBATCH --mail-type=None
STAR --runThreadN 4 --genomeDir ~/project/stargenome/ncrna_idx --genomeLoad LoadAndRemove --readFilesIn ${infile} ${infile/R1/R2} --readFilesCommand zcat --outFileNamePrefix ${outfile} --outFilterIntronMotifs RemoveNoncanonical --outStd BAM_Unsorted --outSAMtype BAM Unsorted --outFilterType BySJout --outReadsUnmapped Fastx --outSAMattributes All --outSAMattrRGline ID:su > /dev/null

EOF
  sbatch rmncRNA.sh
done

