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
#mkdir cache/5o-asmqc
export outdir1=`realpath cache/9o-polished_qc`
#export outdir2=`realpath cache/9o-polished_qc_mini`
export sourcescript=`realpath lib/asmqc`
export bs=301
export asm1=`realpath results/*.fasta`

#out=$(echo $asm| sed 's/.*\///g' |sed 's/.fasta//g')
out=ZM2-1.v0.32
pushd $outdir1

perl $sourcescript/fastaSize.pl $asm1 > fa.size.txt
Rscript --vanilla $sourcescript/generateBin.R  fa.size.txt $bs  fa.bin.$bs.bed

##alignment

# aln
sbatch --export=sourcescript=$sourcescript,filename=$out,ref=$asm1,out=$out,refdb=$out,bed=fa.bin.$bs.bed $sourcescript/repeat.search.polished.sbatch
popd
