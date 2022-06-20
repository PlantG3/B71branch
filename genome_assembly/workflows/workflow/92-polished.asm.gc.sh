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
export outdir2=`realpath cache/9o-polished_qc_mini`
export sourcescript=`realpath lib/asmqc`
export bs=301
export asm1=`realpath results/*v0.42.fasta`
export asm2=`realpath results/*v0.43.fasta`

#out=$(echo $asm| sed 's/.*\///g' |sed 's/.fasta//g')
out=ZM1-2.v0.42
pushd $outdir1

perl $sourcescript/fastaSize.pl $asm1 > fa.size.txt
Rscript --vanilla $sourcescript/generateBin.R  fa.size.txt $bs  fa.bin.$bs.bed

##alignment

# aln
sbatch --export=sourcescript=$sourcescript,filename=$out,ref=$asm1,out=$out,refdb=$out,bed=fa.bin.$bs.bed $sourcescript/repeat.search.polished.sbatch
popd
pushd $outdir2
out=ZM1-2.v0.43
perl $sourcescript/fastaSize.pl $asm2 > fa.size.txt
Rscript --vanilla $sourcescript/generateBin.R  fa.size.txt $bs  fa.bin.$bs.bed
sbatch --export=sourcescript=$sourcescript,filename=$out,ref=$asm2,out=$out,refdb=$out,bed=fa.bin.$bs.bed $sourcescript/repeat.search.polished.sbatch
popd
popd
