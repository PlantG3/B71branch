#!/bin/bash -l
indata=/bulk/liu3zhen/LiuRawData/wheatBlast/0-nanopore/fastqGuppy344/fastq/*fastq
outdir=c19v1
outprefix=c19v1

# load java
module load Java/1.8.0_162
module load gnuplot/5.2.5-foss-2018b

# run canu
/homes/liu3zhen/software/canu/canu-1.9/Linux-amd64/bin/canu \
	-d $outdir -p $outprefix \
	genomeSize=45m \
	minReadLength=5000 \
	minOverlapLength=1000 \
	-gridOptions="--time=10-00:00:00" \
	-nanopore-raw $indata \
	corOutCoverage=80 \
	&>$outprefix.log

