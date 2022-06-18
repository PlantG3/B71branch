#!/bin/bash
perl ~/scripts/fasta/pattern.search.pl -I ../B71Ref2.fasta -P "(TTAGGG|CCCTAA){5,}" -S -O F | grep -e "^chr" -e "^mini" > B71Ref2.telomeres.hits 
cut -f 1,3,4 B71Ref2.telomeres.hits  > B71Ref2.telomeres.hits.bed

