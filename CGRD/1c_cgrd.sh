#!/bin/bash
for fq1 in ../1_trim/*.R1.pair.fq; do
	strain=`echo $fq1 | sed 's/.*\///g' | sed 's/.R1.pair.fq//g'`
	echo $strain
	sbatch --cpus-per-task=16 \
		--mem-per-cpu=1G \
		--time=1-00:00:00 \
		1m_cgrd.sh $strain
done
