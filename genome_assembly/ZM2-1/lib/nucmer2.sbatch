#!/bin/bash -l  
#SBATCH --mem-per-cpu=16G  
#SBATCH --time=0-23:00:00  
#SBATCH --ntasks-per-node=4 
module load R

### nucmer comparisons:
out1=$(echo $fa1 |sed 's/.*\///g' |sed 's/.fasta//g'|sed 's/.fas//g')
out2=$(echo $fa2 |sed 's/.*\///g' |sed 's/.fasta//g'|sed 's/.fas//g')
outdir=$outdir
out=$out1.2.$out2
nucmer --maxmatch --nosimplify $fa1 $fa2 -p $outdir/1o.$out
pwd
###plot
pushd $outdir
R --no-save --slave < /bulk/guifanglin/1-projects/2-wheatblast/utils/lib/nucmer.plot.3.R
