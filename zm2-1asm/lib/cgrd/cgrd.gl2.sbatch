#!/bin/bash
#SBATCH --mem-per-cpu=4G
#SBATCH --time=0-23:00:00
#SBATCH --ntasks-per-node=24


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
