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

module load SAMtools

# out directory
outdir=cache/7o-nanopolish
mkdir $outdir

# reads index
## filter reads less than 5kb
fastqdata=cache/1o-basecall/*/*/pass/*fastq
out=ZM1-2
#infastq=cache/1o-basecall_split/*/*/pass/*fastq
cat cache/1o-basecall_split/*/*/pass/*fastq >  cache/1o-basecall_split/$out.fastq
infastq=cache/1o-basecall_split/$out.fastq

cat $infastq > $outdir/ont_all.fastq
seqtk seq -L 5000 $outdir/ont_all.fastq > $outdir/ont.fastq
rm $outdir/ont_all.fastq

seqsumList=$outdir/1o-seqsum_list
log=$outdir/1o-run.log
reads=$outdir/ont.fastq
f5Dir=$(realpath cache/0-fast5.split/fast5)
fqsum_dir=cache/1o-basecall_split/*/*/sequencing_summary.txt
npDir=./lib/nanopolish
## generate a list for sequencing_summary.txt, including full paths
ls $fqsum_dir -1 > $seqsumList

## index reads:
$npDir/nanopolish index -d $f5Dir -f $seqsumList $reads &>$log






