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
outdir=cache/7o-nanopolish 
out=ZM2-1.v0.3


#cat $outdir/np*/polished/polished.* > $outdir/7o-$out.np.fasta
tail -n 1 $outdir/np[0-9]*/log/*vcf*.log|grep "vcf2fasta" |sed "s/\[vcf2fasta\] rewrote//g"|sort >$outdir/np.change.log
# remove the major contaimination chr for pilon polish.
NC12tig="
tig0002
tig0010
tig0011
tig0014
tig0015
tig0016
tig0024
"
#rm NC12.tigs.v0.3.txt
#for i in $NC12tig
#do 
#echo $i >>NC12.tigs.v0.3.txt
#done

#less cache/6o-re-organize1/ZM2-1.v0.3.ro1.txt |awk '{print $5}'|grep -v -f NC12.tigs.v0.3.txt >keep.chr.id.txt

#perl -ne 'if(/^>(\S+)/){$c=$i{$1}}$c?print:chomp;$i{$_}=1 if @ARGV' keep.chr.id.txt $outdir/7o-$out.np.fasta > $outdir/7o-$out.np.ro2.fasta
#rm keep.chr.id.txt
#rm NC12.tigs.v0.3.txt

