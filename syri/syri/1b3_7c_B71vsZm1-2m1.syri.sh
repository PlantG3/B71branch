#!/bin/bash
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=16G
#SBATCH --time=1-00:00:00

. "/homes/liu3zhen/anaconda3/etc/profile.d/conda.sh"
export PATH="/homes/liu3zhen/anaconda3/bin:$PATH"
conda activate syri

ncpu=$SLURM_CPUS_PER_TASK

syricmd=/homes/liu3zhen/software/syri/syri/syri/bin/syri
ref=../1b1_genome/ZM1-2_2022/1o_ZM1-2.v0.43.g1.fasta
qry=../1b0_ref/B71Ref2.nomt.fasta
out=1b3_7o_B71vsZM1-2m1_syri.gap10kb.out
delta=../1b2_nucmer/1b2_7o_B71vsZM1-2m1.filt.delta
log=1b3_7o_B71vsZM1-2m1_syri.gap10kb.log

show-coords -THrd $delta > ${out}.coords

$syricmd --nc $ncpu \
	-c ${out}.coords \
	-r ${ref} -q ${qry} \
	-d $delta --prefix $out \
	--tdgaplen 10000 --lf $log

rm ${out}.coords

