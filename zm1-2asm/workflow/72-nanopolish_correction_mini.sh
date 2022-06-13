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
module load SAMtools
# alignment
ref=cache/6o-re-organize1/ZM1-2.v0.4.ro3.fasta
reads=cache/7o-nanopolish_mini/ont.fastq
out=ZM1-2.v0.4.ro3
#lib/minimap2/minimap2 -ax map-ont --secondary=no $ref $reads 1>$outdir/$out.sam 2>$outdir/$out.log
## bam and sort
#samtools view -b $outdir/$out.sam | samtools sort -o $outdir/$out.bam
#samtools index $outdir/$out.bam
#rm $outdir/$out.sam



# nanopolish
prefix=npmini
npcor=$(realpath lib/npcor/npcor)
scriptDir=$(realpath lib/npcor)
npDir=$(realpath lib/nanopolish)
javaModule=Java/1.8.0_192
samtoolsModule=SAMtools
ncpu=4
#ref=$(realpath cache/2o-demo.asmv0.1/demo.v0.1.contigs.fasta)
ref=$(realpath $ref)
reads=$(realpath $outdir/ont.fastq)
bam=$(realpath $outdir/$out.bam)
splitseqDir=$(realpath $outdir/2o-split)
log=$(realpath $outdir/np.log)

date > $log
export HDF5_PLUGIN_PATH=/homes/guifanglin/softwares/nanopore/ont-vbz-hdf-plugin-1.0.1-Linux/usr/local/hdf5/lib/plugin/

# spliting
echo "1. split fasta" &>>$log

if [ -d $splitseqDir ]; then
        rm -rf $splitseqDir
fi
mkdir $splitseqDir
pushd $splitseqDir
perl $scriptDir/split.fasta.pl --num 1 --prefix $prefix --decrease $ref &>>$log 
cd ..

echo "2. run NP correction" &>>$log
# run correction
for ctg in $splitseqDir/*[0-9]; do
        echo "np: "$ctg >> $log
        $npcor -n $npDir -f $ctg -r $reads -b $bam \
                -s $scriptDir \
                -l $javaModule \
                -l $samtoolsModule \
                -c $ncpu \
                -g 8 \
                -y 1 \
                >> $log
done
date >> $log
popd


