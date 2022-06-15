#!/bin/bash -l
#SBATCH --mem-per-cpu=2G
#SBATCH --time=0-23:00:00
#SBATCH --cpus-per-task=16

##SBATCH --ntasks-per-node=24
module load SAMtools
module load BEDTools #(update version in the local directory.)
ncpu=$SLURM_CPUS_PER_TASK

/homes/liu3zhen/software/minimap2/minimap2 -x map-ont -d $refdb.mmi $ref
/homes/liu3zhen/software/minimap2/minimap2 -ax map-ont -t $ncpu --secondary=no $refdb.mmi $reads 1>$out.sam 2>$out.log

bam and sort
samtools view -b -@ $ncpu $out.sam | samtools sort -@ $ncpu -o $out.bam
samtools index -@ $ncpu $out.bam
rm $out.sam

#bedtools coverage -a $bed -b $out.bam >4o-$out.coverage.txt
bedtools multicov  -bams $out.bam -bed $bed > $out.counts.txt
#rm $asm.size.txt
#rm $asm.bin.$bs.bed
