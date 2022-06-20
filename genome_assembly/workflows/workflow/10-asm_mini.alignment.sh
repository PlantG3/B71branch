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
outdir=cache/10-asm_mini_checking
mkdir $outdir
module load SAMtools
# alignment
#ref=cache/6o-re-organize1/ZM1-2.v0.4.ro1.fasta
#ref=$outdir/7o-$out.np.fasta
reads=cache/7o-nanopolish/ont.fastq
out=ZM1-2.v0.43
ref=results/ZM1-2.v0.43.fasta
#lib/minimap2/minimap2 -ax map-ont --secondary=no $ref $reads 1>$outdir/$out.sam 2>$outdir/$out.log
## bam and sort
#perl /homes/liu3zhen/scripts/sam/samparser.minimap2.pl -i $outdir/$out.sam --mappingscore 1 --tail 5 100   > $outdir/$out.parse.sam 2>$outdir/$out.parse.log

#samtools view -b $outdir/$out.parse.sam | samtools sort -o $outdir/$out.bam
#samtools index $outdir/$out.bam
#rm $outdir/$out.sam
samtools view -H $outdir/$out.bam >$outdir/$out.mini.sam
samtools view $outdir/$out.bam "mini1" "mini2" >>$outdir/$out.mini.sam
samtools view -b $outdir/$out.mini.sam | samtools sort -o $outdir/$out.mini.bam
samtools index $outdir/$out.mini.bam

rm $outdir/$out.mini.sam

