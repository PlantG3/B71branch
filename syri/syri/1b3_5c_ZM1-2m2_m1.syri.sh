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
qry=../1b1_genome/ZM1-2_2022/1o_ZM1-2.v0.43.g2.fasta
delta=../1b2_nucmer/1b2_5o_ZM1-2m2vs-m1.filt.delta

out=1b3_5o_ZM1-2m2_m1.gap10kb
log=1b3_5o_ZM1-2m2_m1.gap10kb.log

show-coords -THrd $delta > ${out}.coords
$syricmd --nc $ncpu \
	-c ${out}.coords \
	-r ${ref} -q ${qry} \
	-d $delta --prefix $out \
	--tdgaplen 10000 --lf $log

rm ${out}.coords

