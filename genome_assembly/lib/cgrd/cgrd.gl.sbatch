#!/bin/bash
#SBATCH --mem-per-cpu=4G
#SBATCH --time=0-23:00:00
#SBATCH --ntasks-per-node=8


###SBATCH --cpus-per-task=24
###SBATCH --partition=ksu-gen-highmem.q,ksu-plantpath-liu3zhen.q

#ref=/bulk/guifanglin/project/wheat/0_reference/tauschii/Aet_v4.0_parts/Aet_v4.0_parts.fasta
#reffq1=/bulk/guifanglin/project/wheat/14-NLRs/4-genome_walking/1-trim/BW_01192_DDPL00391-W_HG32HALXX_L8.R1.pair.fq.gz
#reffq2=/bulk/guifanglin/project/wheat/14-NLRs/4-genome_walking/1-trim/BW_01192_DDPL00391-W_HG32HALXX_L8.R2.pair.fq.gz
#qryfq1=/bulk/guifanglin/project/wheat/14-NLRs/4-genome_walking/1-trim/BW_01001.R1.pair.fq.gz
#qryfq2=/bulk/guifanglin/project/wheat/14-NLRs/4-genome_walking/1-trim/BW_01001.R2.pair.fq.gz
#subject=$(echo $reffq1 |sed 's/.*\///g' |sed 's/R1.pair.fq//g'|sed 's/_.*//g')
#query=$(echo $qryfq1 |sed 's/.*\///g' |sed 's/R1.pair.fq//g'|sed 's/_.*//g')
echo $subject
echo $query
echo $reffq1
echo $qryfq1
echo $ref
chr=$(grep ">" $ref|sed 's/>//g' | sed -e 's/\n/ /g')
echo $chr
. /opt/software/software/Anaconda3/2019.03/etc/profile.d/conda.sh
conda activate /homes/guifanglin/.conda/envs/cgrd

perl ~/scripts_gl/CGRD/version3/CGRD/cgrd --ref $ref \
        --subj $subject  --sfq1 $reffq1 --sfq2 $reffq2 \
        --qry $query -qfq1 $qryfq1 -qfq2 $qryfq2 \
        --knum 300 --threads 8
