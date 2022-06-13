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

###ln all the fast5 and summary files
mkdir input/fast5
ln -s /bulk/guifanglin/raw/nanopore/ZM2-1/WGS*/*/*/fast5/* input/fast5/
ln -s /bulk/guifanglin/raw/nanopore/ZM2-1/WGS*/*/*/sequencing_summary_*.txt input/fast5/



rm -r cache/0-fast5.split
mkdir cache/0-fast5.split
mkdir cache/0-fast5.split/fast5

readnum=500
indir=input/fast5
outdir=cache/0-fast5.split/fast5
for seqsum in $indir/sequencing_summary_*.txt
do
runname=$(echo $seqsum|sed 's/.*\///g'|sed 's/.txt//g' |sed 's/sequencing_summary_//g')
echo $runname
prefix=$runname\_
echo $prefix
mkdir $outdir/$runname
      fast5_subset -t 4 -f $prefix --input $indir --save_path $outdir/$runname --read_id_list $seqsum --batch_size $readnum --recursive
done

rm input/fast5 -r
