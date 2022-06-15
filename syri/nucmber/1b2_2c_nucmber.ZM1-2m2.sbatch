#!/bin/bash -l
#SBATCH --mem-per-cpu=2G
#SBATCH --time=1-00:00:00
#SBATCH --cpus-per-task=16

b71=../1b0_ref/B71Ref2.nomt.fasta
qry=../1b1_genome/ZM1-2_2022/1o_ZM1-2.v0.43.g2.fasta
out=1b2_1o_ZM1-2m2vsB71

/homes/liu3zhen/local/bin/nucmer --maxmatch -c 500 -b 500 -l 20 -t 16 -p $out $b71 $qry
# filter
/homes/liu3zhen/local/bin/delta-filter -m -i 90 -l 500 ${out}.delta  > ${out}.filt.delta
#/homes/liu3zhen/local/bin/show-coords -THrd ${out}.filt.delta > ${out}.filt.delta.txt

