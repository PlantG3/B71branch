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

cat $outdir/npmini[0-9]*/polished/polished.* > $outdir/7o-$out.npmini.fasta
tail -n 1 $outdir/npmini[0-9]*/log/*vcf*.log|grep "vcf2fasta" |sed "s/\[vcf2fasta\] rewrote//g" |sort >$outdir/npmini.change.log
