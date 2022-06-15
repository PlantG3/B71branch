#!/bin/bash
funannotate train --cpus 32 \
	-i data/B71Ref2.softmasked.fasta \
	-o B71Ref2_trainSE \
	--species "Magnaporthe oryzae" --isolate B71 --strain B71 \
	--no_trimmomatic --jaccard_clip \
	--stranded R \
	--single data/culture-1.fq data/culture-2.fq data/culture-3.fq \
		data/inpla26-1.fq data/inpla26-2.fq data/inpla40-1.fq \
		data/inpla40-2.fq data/inpla40-3.fq
