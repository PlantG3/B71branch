#!/bin/bash -l
#SBATCH --cpus-per-task=16
#SBATCH --mem-per-cpu=2G
#SBATCH --time=0-24:00:00
#SBATCH --partition=ksu-gen-reserved.q,batch.q,ksu-biol-ari.q,ksu-plantpath-liu3zhen.q

module load SAMtools/1.9-foss-2018b

ncpu=$SLURM_CPUS_PER_TASK
ref=/bulk/liu3zhen/research/projects/wheatBlast2.0/06-B71asm.nanopore.Guppy344/asm1_canu1.9/c19v1/c19v1.contigs.fasta
reads=/bulk/liu3zhen/research/projects/wheatBlast2.0/06-B71asm.nanopore.Guppy344/guppy344/B71.guppy344.gt5kb.fastq
out=1o-reads2ref
refdb=c19v1

# aln
/homes/liu3zhen/software/minimap2/minimap2 -ax map-ont -N 0 -t $ncpu ${refdb}.mmi $reads 1>$out.sam 2>$out.log

# bam and sort
samtools view -b -@ $ncpu $out.sam | samtools sort -@ $ncpu -o $out.bam
samtools index $out.bam

