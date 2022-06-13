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

infolder=cache/0-fast5.split

#mkdir cache/1o-basecall
lib/cpuGuppy_resume_v3_4percaller -d $infolder -o cache/1o-basecall_split\
                -s lib/ont-guppy-cpu_6.0.1/bin \
                -k SQK-LSK110 \
                -c FLO-MIN110 \
                -t dna \
                -f dna_r9.4.1_450bps_hac.cfg \
		-n 2540 \
                -u 4
#-r
#dna_r9.4.1_450bps_hac high accuracy model
#dna_r9.4.1_450bps_sup super accurate model
popd
#Tue Feb  8 11:53:49 CST 2022
#Submitted batch job 3770160
