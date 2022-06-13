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

module load R
module load BEDTools
module load SAMtools

#infastq=cache/1o-basecall_split/*/*/pass/*fastq
mkdir cache/5o-asmqc
export outdir=`realpath cache/5o-asmqc`
export sourcescript=`realpath lib/asmqc`
export bs=500
export asm=`realpath cache/3o-*.asmv0.4/*contigs.fasta`
out=$(echo $asm| sed 's/.*\///g' |sed 's/contigs.fasta//g')

pushd $outdir

perl $sourcescript/fastaSize.pl $asm > fa.size.txt
#awk '$2>50000' fa.size.txt.tmp > fa.size.txt
Rscript --vanilla $sourcescript/generateBin.R  fa.size.txt $bs  fa.bin.$bs.bed

##alignment

# aln
sbatch --export=sourcescript=$sourcescript,filename=$out,ref=$asm,out=$out,refdb=$out,bed=fa.bin.$bs.bed $sourcescript/repeat.search.sbatch
popd
popd
