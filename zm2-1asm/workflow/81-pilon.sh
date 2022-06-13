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
outdir=cache/8o-pilon
indir=cache/7o-nanopolish
out=ZM2-1.v0.3
mkdir $outdir
outdir=$(realpath $outdir)
pilonJar=$(realpath lib/pilon-1.24.jar)
module load SAMtools
module load Java

ref=$(realpath $indir/7o-$out.np2.ro2.fasta)
refname=$(echo $ref |sed 's/.*\///g')
newasm=$(echo $outdir/$out.np2.pilon.fasta)
log=$(echo $outdir/1o-pilon.log)
echo $ref
echo $refname
echo $newasm
echo $log
pe1=/bulk/liu3zhen/research/projects/wheatBlast2.0/09-Zambia/1_trim/ZM_2_1.R1.pair.fq.gz
pe2=/bulk/liu3zhen/research/projects/wheatBlast2.0/09-Zambia/1_trim/ZM_2_1.R2.pair.fq.gz

# tmp directory
tmpdir=1otmp
mkdir $outdir/$tmpdir

# aln
pushd $outdir/$tmpdir
grep -v "tig" $ref |sed 's/>//g' >$out.chr.list.txt
perl -ne 'if(/^>(\S+)/){$c=$i{$1}}$c?print:chomp;$i{$_}=1 if @ARGV' $out.chr.list.txt $ref > $out.ro3.fasta
rm $out.chr.list.txt
ref=$(realpath $out.ro3.fasta)
refname=$out.ro3.fasta
#ln -s $ref .
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
        --output 1o-pilon \
        --outdir . \
        --minmq 40 \
        --minqual 15 \
        --changes --vcf &>$log

# cleanup
#rm $tmpdir -rf

sed 's/_pilon//g' 1o-pilon.fasta >$newasm
rm 1o-pilon.fasta
popd
popd
less ../cache/8o-pilon/1o-pilon.changes |awk '{print $1}'|sed 's/:/\t/g'|awk '{print $1}'|sort|uniq -c > ../cache/8o-pilon/1o-pilon.changes.summary.txt
