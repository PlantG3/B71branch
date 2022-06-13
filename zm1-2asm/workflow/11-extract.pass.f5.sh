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

#rm -r cache/0-fast5.split
#mkdir cache/0-fast5.split
#mkdir cache/0-fast5.split/fast5
mkdir cache/11-pass.fast5
outdir=cache/11-pass.fast5
readnum=4000
indir=cache/0-fast5.split/fast5

head -n 1 cache/1o-basecall_split/0-fast5.split/1/sequencing_summary.txt >$outdir/all.sequencing_summary.txt
less cache/1o-basecall_split/0-fast5.split/*/sequencing_summary.txt |awk '$10=="TRUE"' >>$outdir/all.sequencing_summary.txt

for seqsum in $outdir/all.sequencing_summary.txt
do
#runname=$(echo $seqsum|sed 's/.*\///g'|sed 's/.txt//g' |sed 's/sequencing_summary_//g')
#echo $runname
#prefix=$runname\_
prefix=ZM1_2_FAR31708_47ee3bf4_dae3f835_
echo $prefix
mkdir $outdir/$runname
      fast5_subset -t 24 -f $prefix --input $indir --save_path $outdir/$runname --read_id_list $seqsum --batch_size $readnum --recursive
done

