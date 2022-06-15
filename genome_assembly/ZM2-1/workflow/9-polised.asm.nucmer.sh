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

#infastq=cache/1o-basecall_split/*/*/pass/*fastq
export outdir=`realpath cache/9o-polished_qc`
mkdir $outdir
# load java
module load SAMtools/1.9-foss-2018b
module load Java/1.8.0_192

export B71="/bulk/liu3zhen/research/projects/wheatBlast2.0/10-B71Ref2/0-genome/B71Ref2.fasta"
sbatch --export=fa1=$B71,fa2=$B71,outdir=$outdir lib/nucmer.sbatch
#export ZM1_2=../2-ZM1-2/results/ZM1-2.v0.41.fasta
export ZM2_1=results/ZM2-1.v0.32.fasta
sbatch --export=fa1=$ZM2_1,fa2=$B71,outdir=$outdir lib/nucmer.sbatch
sbatch --export=fa1=$ZM2_1,fa2=$ZM2_1,outdir=$outdir lib/nucmer.sbatch
#export asm=cache/3o-*.asmv0.3/*contigs.fasta
#sbatch --export=fa1=$ZM2_1,fa2=$B71,outdir=$outdir lib/nucmer.sbatch
#export asm=cache/3o-*.asmv0.5/*contigs.fasta
#sbatch --export=fa1=$ZM1_2,fa2=$ZM2_1,outdir=$outdir lib/nucmer.sbatch
