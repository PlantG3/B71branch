#!/bin/bash
fq1=data/MoTB71-RNA-Lib1-5min_S1_L001.R1.pair.fq.gz
fq2=data/MoTB71-RNA-Lib1-5min_S1_L001.R2.pair.fq.gz
funannotate train --cpus 64 \
	-i data/B71Ref2.softmasked.fasta \
	-o B71b \
	--left $fq1 --right $fq2 \
	--species "Magnaporthe oryzae" --isolate B71 --strain B71 \
	--no_trimmomatic --jaccard_clip 2>annot_b_1b_trainPE.log

