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
outdir=cache/6o-re-organize1
#mkdir $outdir
export sourcescript=`realpath lib/asmqc`
export asm=`realpath cache/3o-*v0.4/*contigs.fasta`
out=$(echo $asm| sed 's/.*\///g' |sed 's/.contigs.fasta//g')

pushd $outdir

#perl $sourcescript/fastaSize.pl $asm |awk '{print $1 "\t" 1 "\t" $2 "\t" "plus" "\t" $1 "\t" 1}' |awk 'BEGIN{FS=OFS="\t"}{gsub(/tig0000/, "tig", $5)} {print $0}'|sort -k1 > $out.ro1.draft.txt
perl $sourcescript/fasta.reorganiz.pl --fasta $asm --table $out.ro2.txt > $out.ro2.fasta

# then manually edit the chr and orientation based on the B71Ref2 GENOME.
#perl $sourcescript/fastaSize.pl $asm |awk '{print $1 "\t" 1  "\t" $2 "\t" "plus"} {gsub(/"tig0000"/, "tig", $1)} {print 1}' > $out.ro1.draft.txt
##alignment

# aln
popd
popd
