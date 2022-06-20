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
#mkdir cache/4o-nucmer
export outdir=`realpath cache/6o-*`

# load java
module load SAMtools/1.9-foss-2018b
module load Java/1.8.0_192

export B71="/bulk/liu3zhen/research/projects/wheatBlast2.0/10-B71Ref2/0-genome/B71Ref2.fasta"

export asm=$outdir/*ro1.fasta
sbatch --export=fa1=$asm,fa2=$B71,outdir=$outdir lib/nucmer2.sbatch
export asm=$outdir/*ro1.fasta
sbatch --export=fa1=$asm,fa2=$asm,outdir=$outdir lib/nucmer2.sbatch


#export TF05="/bulk/guifanglin/1-projects/2-wheatblast/1-TF05-1/1-asm/results/2r-polished/1ac_TF051mc7sp1np2020/1ac_TF051mc7sp1np2020.v0.222.fasta"
#sbatch --export=fa1=$asm,fa2=$TF05,outdir=$outdir lib/nucmer.sbatch

export zm12="/bulk/guifanglin/1-projects/2-wheatblast/2-ZM1-2/results/ZM1-2.v0.41.fasta"
sbatch --export=fa1=$asm,fa2=$zm12,outdir=$outdir lib/nucmer.sbatch
