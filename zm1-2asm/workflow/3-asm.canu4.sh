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
out=ZM1-2
infastq=cache/2o-qc/$out.fq
infastq=cache/1o-basecall_split/*/*/pass/*fastq
#cat cache/$out/*/*/pass/*fastq >  cache/$out/$out.fastq
# load java
module load Java/1.8.0_162
#module load gnuplot
# run canu
time lib/canu-2.2/bin/canu -d cache/3o-$out.asmv0.4 -p $out.v0.4 \
        genomeSize=45m \
        minReadLength=5000 \
        minOverlapLength=1500 \
        -nanopore $infastq \
	corOutCoverage=80 \
	correctedErrorRate=0.1 \
        -gridOptions="--time=0-23:00:00" \
        -gridOptionsUTGOVL="--cpus-per-task=24" \
        -gridOptionsCOR="--cpus-per-task=16" \
        -gridOptionsOBTOVL="--cpus-per-task=16" \
        corPartitionMin=10000 \
        obtovlThreads=16 \
        utgovlThreads=24 \
        corThreads=16 \
	&> cache/3o-$out.asmv0.1.log 
#correctedErrorRate=0.05 \
