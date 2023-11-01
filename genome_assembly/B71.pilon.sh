#!/bin/bash -l
#SBATCH --cpus-per-task=32
#SBATCH --mem-per-cpu=2g
#SBATCH --time=0-23:00:00
##SBATCH --partition=ksu-gen-highmem.q,ksu-plantpath-liu3zhen.q,ksu-biol-ari.q,batch.q

module load SAMtools/1.9-foss-2018b
module load Java/1.8.0_192
cpunum=$SLURM_CPUS_PER_TASK
pilonJar=/homes/liu3zhen/software/pilon/pilon-1.23.jar
pe1=/bulk/liu3zhen/research/projects/wheatBlast2.0/00-B71v1/00-Illumina/B71.R1.pair.fq
pe2=/bulk/liu3zhen/research/projects/wheatBlast2.0/00-B71v1/00-Illumina/B71.R2.pair.fq
fasta=/bulk/liu3zhen/research/projects/wheatBlast2.0/06-B71asm.nanopore.Guppy344/asm1_canu1.9/6_noFlyePolish/2-np2/B71ONTc1.9v1.np2.fasta
asm=`echo $fasta | sed 's/.*\///g'`
newasm=B71ONTc1.9v1.np2.p1

# tmp directory
tmpdir=1otmp
mkdir $tmpdir

# aln
pushd $tmpdir

ln -s $fasta .
bwa index $asm

out=read2asm

# alignment
bwa mem -t $cpunum $asm $pe1 $pe2 > $out.sam

# sam2bam
samtools view -@ $cpunum -b $out.sam -o $out.bam
samtools sort -@ $cpunum $out.bam -o $out.sort.bam
samtools index -@ $cpunum $out.sort.bam

popd

# pilon
java -Xmx64g -jar $pilonJar \
	--genome $fasta \
	--frags $tmpdir/$out.sort.bam \
	--output $newasm \
	--outdir . \
	--minmq 40 \
	--fix bases \
	--minqual 15 \
	--threads 32 \
	--changes --vcf &>$newasm.pilon.log

# cleanup
rm $tmpdir -rf

