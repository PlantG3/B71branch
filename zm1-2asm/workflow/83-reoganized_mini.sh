#!/bin/sh

####################################
# normalize your dir to the root level of the repo
function canonicalPath
{
    local path="$1" ; shift
    if [ -d "$path" ]
    then
        echo "$(cd "$path" ; pwd)"
    else
        local b=$(basename "$path")
        local p=$(dirname "$path")
        echo "$(cd "$p" ; pwd)/$b"
    fi
}
####################################
# usage example
mycanonicalpath=$(canonicalPath "../")
echo $mycanonicalpath
pushd $mycanonicalpath

# out directory
outdir=cache/8o-pilon_mini
indir=cache/7o-nanopolish_mini
out=ZM1-2.v0.4.ro3
#mkdir $outdir
outdir=$(realpath $outdir)
pilonJar=$(realpath lib/pilon-1.24.jar)
module load SAMtools
module load Java

ref=$(realpath $outdir/$out.np2.pilonmini.fasta)
refname=$(echo $ref |sed 's/.*\///g')
newasm=$(echo $outdir/$out.np2.pilonmini2.fasta)
log=$(echo $outdir/1o-pilonmini2.log)

pe1=/bulk/liu3zhen/research/projects/wheatBlast2.0/09-Zambia/1_trim/ZM_1_2.R1.pair.fq.gz
pe2=/bulk/liu3zhen/research/projects/wheatBlast2.0/09-Zambia/1_trim/ZM_1_2.R2.pair.fq.gz


popd
less ../cache/8o-pilon_mini/2o-pilon*2.changes |awk '{print $1}'|sed 's/:/\t/g'|awk '{print $1}'|sort|uniq -c > ../results/2o-pilonmini2.changes.summary.txt

#####################################################
# order and write the final assembly to the results.
#in=$out
out=ZM1-2.v0.43
#ZM1-2.v0.43 the mini contigs were assembled.

rm ../results/$out.fasta
seqname=$(grep ">" $newasm |sed 's/>//g'|sort)
for seq in $seqname
do
echo $seq >tmp
perl -ne 'if(/^>(\S+)/){$c=$i{$1}}$c?print:chomp;$i{$_}=1 if @ARGV' tmp $newasm >>../results/$out.fasta
done
rm tmp
#remove this code if tig number more than 100
sed -i 's/tig00/tig/g' ../results/$out.fasta 
