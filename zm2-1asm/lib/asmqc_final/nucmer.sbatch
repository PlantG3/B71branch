#!/bin/bash -l  
#SBATCH --mem-per-cpu=16G  
#SBATCH --time=0-23:00:00  
#SBATCH --ntasks-per-node=4 
module load R

### nucmer comparisons:
out1=$(echo $fa1 |sed 's/.*\///g' |sed 's/.fasta//g'|sed 's/.fas//g')
out2=$(echo $fa2 |sed 's/.*\///g' |sed 's/.fasta//g'|sed 's/.fas//g')
out=$out1.2.$out2
#nucmer --maxmatch --nosimplify $fa1 $fa2 -p 1o.$out
pwd
###plot
R --no-save --slave < ../../../main/5_qc/utils/plot.R 
