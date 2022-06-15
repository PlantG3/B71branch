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
outdir=cache/8o-align
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
grep "tig" $ref |sed 's/>//g' >$out.tig.list.txt
perl -ne 'if(/^>(\S+)/){$c=$i{$1}}$c?print:chomp;$i{$_}=1 if @ARGV' $out.tig.list.txt $ref > $out.tig.fasta
rm $out.tig.list.txt
ref=$out.tig.fasta
refname=$out.tig.fasta
#ln -s $ref .
#bwa index $refname
#out=1o-read2asm
# alignment
#bwa mem $refname $pe1 $pe2 > $out.sam

perl /homes/liu3zhen/local/slurm/bwa_filter/samparser.bwa.sbatch.pl \
        --mem 6G \
        --time 0-23:00:00 \
        --threads 4 \
        --indir . \
        --outdir . \
        --parserScript "/homes/liu3zhen/local/slurm/bwa_filter/samparser.bwa.pl" \
        --samtoolsModule "SAMtools/1.8-foss-2017beocatb" \
        --insert_min 60 \
        --insert_max 800 \
        --min_iden 50 \
        --max_mismatch_perc 6 \
        --max_tail_perc 5 \
        --gap 0 \
        --min_socre 40 \
        --filefeature ".sam"
# sam2bam
#samtools view -b $out.sam -o $out.bam
#samtools sort $out.bam -o $out.sort.bam
#samtools index $out.sort.bam

popd
