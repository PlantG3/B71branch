#!/bin/bash
#SBATCH --cpus-per-task=24
#SBATCH --mem-per-cpu=2g
#SBATCH --time=1-00:00:00
fasta=../3_snp/Mo.3.recode.min6.fasta
in=Mo.4.fasta
ln -s $fasta $in
model=SYM+ASC+R2
#GTR+F+ASC+R2
# model test
/homes/liu3zhen/software/iqtree/iqtree-1.6.12-Linux/bin/iqtree \
	-s $in -m $model -bb 1000 -nt 24 -redo
	#-mtree


