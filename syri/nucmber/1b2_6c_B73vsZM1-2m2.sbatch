#!/bin/bash -l
#SBATCH --mem-per-cpu=2G
#SBATCH --time=1-00:00:00
#SBATCH --cpus-per-task=16

ref=../1b1_genome/ZM1-2_2022/1o_ZM1-2.v0.43.g2.fasta
qry=../1b0_ref/B71Ref2.nomt.fasta
out=1b2_6o_B71vsZM1-2m2

/homes/liu3zhen/local/bin/nucmer --maxmatch -c 500 -b 500 -l 20 -t 16 -p $out $ref $qry
# filter
/homes/liu3zhen/local/bin/delta-filter -m -i 90 -l 500 ${out}.delta  > ${out}.filt.delta
#/homes/liu3zhen/local/bin/show-coords -THrd ${out}.filt.delta > ${out}.filt.delta.txt

