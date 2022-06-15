#!/bin/bash
out=B71b
#funannotate remote -i B71b -m antismash -e liu3zhen@gmail.com
funannotate remote -i $out -m phobius -e liu3zhen@ksu.edu 2>annot_b_5_annotate.log
funannotate annotate -i $out --cpus 64 --sbt data/B71.sbt 2>>annot_b_5_annotate.log

