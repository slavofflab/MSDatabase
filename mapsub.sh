#!/bin/bash
mkdir map
for infile in ./rmncrna/*.Unmapped.out.mate1
do
  outfile=${infile/rmncrna/map}
  outfile=${outfile/.Unmapped.out.mate1/.}
  cat>map.sh<<EOF
#!/bin/bash
#SBATCH --job-name=readmapping
#SBATCH --out="slurm-%j.out"
#SBATCH --partition=day
#SBATCH --time=4:00:00
#SBATCH --nodes=1 --ntasks=1 --cpus-per-task=16
#SBATCH --mem-per-cpu=3G
#SBATCH --mail-type=None
STAR --runThreadN 16 --genomeDir ~/project/stargenome/hg38_idx --genomeLoad LoadAndRemove --readFilesIn ${infile} ${infile/mate1/mate2} --outFileNamePrefix ${outfile} --outFilterIntronMotifs RemoveNoncanonical --outStd BAM_Unsorted --outSAMtype BAM Unsorted --outFilterType BySJout --outReadsUnmapped Fastx --outSAMattributes All --outSAMstrandField intronMotif > ${outfile}mapped.bam

EOF
  sbatch map.sh
done

