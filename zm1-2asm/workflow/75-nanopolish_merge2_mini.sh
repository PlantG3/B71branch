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
outdir=cache/7o-nanopolish_mini 
out=ZM1-2.v0.4.ro3

cat $outdir/npminiwo*/polished/polished.* > $outdir/7o-$out.npmini2.fasta
tail -n 1 $outdir/npminiwo*/log/*vcf*.log|grep "vcf2fasta" |sed "s/\[vcf2fasta\] rewrote//g"|sort >$outdir/npmini2.change.log
