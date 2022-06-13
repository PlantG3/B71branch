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
out=ZM2-1.v0.3
script=`realpath lib/gfa`
prefix=ZM2-1.v0.3
outdir=cache/3o-*v0.3
pushd $outdir

readtotig=$prefix.contigs.layout.readToTig
gfa=unitigging/4-unitigger/$prefix.best.edges.gfa
## rename the read id map
awk '{print 100000000+$1 "\t" "rd" $1 "_tig" $2 ":" $3 "-" $4}' $readtotig|sed 's/^1/read/g'|tail -n +2 |sort -k1 >$readtotig.tmp
awk -f $script/vlookup_c2.awk  $readtotig.tmp $gfa >$prefix.best.edges.gfa.tmp
awk -f $script/vlookup_c4.awk  $readtotig.tmp $prefix.best.edges.gfa.tmp >$prefix.best.edges.tiginf.gfa
rm *.tmp
popd
popd
