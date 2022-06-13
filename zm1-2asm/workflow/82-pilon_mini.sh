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
#mkdir $outdir
outdir=$(realpath $outdir)
pilonJar=$(realpath lib/pilon-1.24.jar)
module load SAMtools
module load Java

ref=$(realpath $outdir/$out.np2.pilonmini.fasta)
refname=$(echo $ref |sed 's/.*\///g')
newasm=$(echo $outdir/$out.np2.pilonmini2.fasta)
log=$(echo $outdir/1o-pilonmini2.log)

pe1=/bulk/liu3zhen/research/projects/wheatBlast2.0/09-Zambia/1_trim/ZM_1_2.R1.pair.fq.gz
pe2=/bulk/liu3zhen/research/projects/wheatBlast2.0/09-Zambia/1_trim/ZM_1_2.R2.pair.fq.gz

# tmp directory
tmpdir=2otmp
mkdir $outdir/$tmpdir

# aln
pushd $outdir/$tmpdir
ln -s $ref .
bwa index $refname
out=2o-read2asm
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
        --output 2o-pilonmini2 \
        --outdir . \
        --minmq 40 \
        --minqual 15 \
        --changes --vcf &>$log

# cleanup
rm $tmpdir -rf


sed 's/_pilon//g' 2o-pilonmini2.fasta >$newasm
rm 2o-pilonmini2.fasta
popd
popd
less ../cache/8o-pilon_mini/2o-pilon*2.changes |awk '{print $1}'|sed 's/:/\t/g'|awk '{print $1}'|sort|uniq -c > ../results/2o-pilonmini2.changes.summary.txt

#####################################################
# order and write the final assembly to the results.
#in=$out
out=ZM1-2.v0.43
#ZM1-2.v0.43 the mini contigs were assembled.

rm ../results/$out.fasta
seqname=$(grep ">" $newasm |sed 's/>//g'|sort)
for seq in $seqname
do
echo $seq >tmp
perl -ne 'if(/^>(\S+)/){$c=$i{$1}}$c?print:chomp;$i{$_}=1 if @ARGV' tmp $newasm >>../results/$out.fasta
done
rm tmp
#remove this code if tig number more than 100
sed -i 's/tig00/tig/g' ../results/$out.fasta 
