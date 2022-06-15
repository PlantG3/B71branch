#!/bin/bash
#SBATCH --cpus-per-task=16
#SBATCH --mem-per-cpu=3G
#SBATCH --time=0-23:00:00
#conda activate base
module load R
fq1=/bulk/liu3zhen/LiuProjectBackup/wheatBlast/0-Illumina/trim/FCHVLF2BCXX_L1_wHAXPI033889-4.R1.pair.fq
fq2=/bulk/liu3zhen/LiuProjectBackup/wheatBlast/0-Illumina/trim/FCHVLF2BCXX_L1_wHAXPI033889-4.R2.pair.fq
Ref1=/bulk/liu3zhen/research/projects/wheatBlast2.0/00-db/11-B71Ref1/B71Ref1_plus_mt.fas
Ref16=/bulk/liu3zhen/research/projects/wheatBlast2.0/06-B71Ref1.6/1-B71Ref1.6/B71Ref1.6.fasta
Ref2=/bulk/liu3zhen/research/projects/wheatBlast2.0/07-B73Ref2_Guppy344/1-asm1_canu1.9/5-Ref2/B71Ref2/B71Ref2.fasta
prefix=1o-B71asm

perl ~/scripts2/KAD/KADprofile.pl \
	--read $fq1 --read $fq2 \
	--asm $Ref1 --aid Ref1.0 \
	--asm $Ref16 --aid Ref1.6 \
	--asm $Ref2 --aid Ref2.0 \
	--minc 5 \
	--klen 35 \
	--prefix $prefix

