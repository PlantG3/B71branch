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
mkdir $outdir
outdir=$(realpath $outdir)
pilonJar=$(realpath lib/pilon-1.24.jar)
module load SAMtools
module load Java

ref=$(realpath $indir/7o-$out.npmini2.fasta)
refname=$(echo $ref |sed 's/.*\///g')
newasm=$(echo $outdir/$out.np2.pilonmini.fasta)
log=$(echo $outdir/1o-pilon.log)

pe1=/bulk/liu3zhen/research/projects/wheatBlast2.0/09-Zambia/1_trim/ZM_1_2.R1.pair.fq.gz
pe2=/bulk/liu3zhen/research/projects/wheatBlast2.0/09-Zambia/1_trim/ZM_1_2.R2.pair.fq.gz

# tmp directory
tmpdir=1otmp
mkdir $outdir/$tmpdir

# aln
pushd $outdir/$tmpdir
ln -s $ref .
bwa index $refname
out=1o-read2asm
# alignment
bwa mem $refname $pe1 $pe2 > $out.sam

# sam2bam
samtools view -b $out.sam -o $out.bam
samtools sort $out.bam -o $out.sort.bam
samtools index $out.sort.bam

cd ..

# pilon
java -Xmx96g -jar $pilonJar \
        --genome $tmpdir/$refname \
        --frags $tmpdir/$out.sort.bam \
        --output 1o-pilonmini \
        --outdir . \
        --minmq 40 \
        --minqual 15 \
        --changes --vcf &>$log

# cleanup
rm $tmpdir -rf


sed 's/_pilon//g' 1o-pilonmini.fasta >$newasm
rm 1o-pilonmini.fasta
popd
popd
less ../cache/8o-pilon_mini/1o-pilon*.changes |awk '{print $1}'|sed 's/:/\t/g'|awk '{print $1}'|sort|uniq -c > ../cache/8o-pilon_mini/1o-pilonmini.changes.summary.txt
