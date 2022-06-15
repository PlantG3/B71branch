#!/bin/bash

indir=../0_raw
fq1feature=_1.fastq.gz
fq2feature=_2.fastq.gz
trimmomatic=/homes/liu3zhen/local/jars/trimmomatic-0.38.jar
trim_pl=~/corescripts/slurm/trimmomatic.sbatch.pl
trim_sh=~/local/slurm/trimmomatic/trimmomatic.pe.sh
adap_file=~/pipelines/trimmomatic/adaptorDB/illumina_GAIIx_HiSeq-PE_NexteraPE.fa
perl $trim_pl \
	--mem 6G \
	--time 18:00:00 \
	--trimmomatic $trimmomatic \
	--outdir "." \
	--adaptor_file $adap_file \
	--trim_shell $trim_sh \
	--indir $indir \
	--fq1feature $fq1feature \
	--fq2feature $fq2feature \
	--threads 4 \
	--min_len 60

