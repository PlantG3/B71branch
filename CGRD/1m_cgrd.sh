#!/bin/bash
strain=$1
. "/homes/liu3zhen/anaconda3/etc/profile.d/conda.sh"
export PATH="/homes/liu3zhen/anaconda3/bin:$PATH"
conda activate cgrd
sfq1=../../00-B71v1/00-Illumina/B71.max125bp.R1.pair.fq
sfq2=../../00-B71v1/00-Illumina/B71.max125bp.R2.pair.fq
qfq1=../1_trim/${strain}.R1.pair.fq
qfq2=../1_trim/${strain}.R2.pair.fq
qry=${strain}
ref=../../10-B71Ref2/0-genome/B71Ref2.fasta
binbed=1i_B71.1500bp.uniq.bed
perl ~/scripts2/CGRD/cgrd --ref $ref \
	--binbed $binbed \
	--subj B71 --sfq1 $sfq1 --sfq2 $sfq2 \
	--qry $qry -qfq1 $qfq1 -qfq2 $qfq2 \
	--adj0 --cleanup \
	--groupval "-5 -0.4 0.4 0.8" \
	--prefix $qry --threads 16

#binbed=/homes/liu3zhen/scripts2/CGRD/databases/binbed/MoT_B71Ref2.knum300.bin.bed
#--groupval "-5 -0.4 0.4 0.8"

