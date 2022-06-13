#!/bin/bash -l  
#SBATCH --mem-per-cpu=2G  
#SBATCH --time=0-00:05:00  
#SBATCH --ntasks-per-node=2

module load BLAST+
module load R
## search for telomeres
perl $sourcescript/pattern.search.pl -I $ref -P "(TTAGGG|CCCTAA){5,}" -S -O F |cut -f 1,4,5 |grep "#" -v | grep "Seq_name" -v |sort -k1,1 -k2,2n | awk '{print $1 "\t" $(NF-1)-1 "\t" $(NF)}'  > $out.telomeres.hits.bed

## MoTER1
makeblastdb -in $ref -out $refdb -dbtype nucl -parse_seqids
blastn -query $sourcescript/MoTER1RT.fas -db $refdb -outfmt 6 | awk '($8 - $7) > 500' | awk '{if ($10 > $9) print $2"\t"$9"\t"$10; else print $2"\t"$10"\t"$9 }' | sort -k1,1 -k2,2n > $refdb.MoTER1RT.min500bp.bed
#ref=../../B71Ref2.fasta
#inbed=../../1-repeatmask/2o-B71Ref2.repeat.bed
#bed=1o-MoTeR1.bed
#minmatch=1000
#outfas="1o-MoTER1RT.min"$minmatch"bp.fasta"
#awk -v m=$minmatch '{ if (($3 - $2) >= m ) print }' $inbed | grep "MoTeR1" > $bed

### extract sequences:
#bedtools getfasta -fi $ref -bed $bed -fo $outfas

## 18srDNA
blastn -query $sourcescript/18srDNA.fasta -db $refdb -outfmt 6 | awk '($8 - $7) > 500' | awk '{if ($10 > $9) print $2"\t"$9"\t"$10; else print $2"\t"$10"\t"$9 }'|sort -k1,1 -k2,2n > $refdb.18srDNA.min500bp.bed

###cen1 to 7

# alignment
nucmer -l 50 -t 8 -p $out.centromeres $ref $sourcescript/B71Ref1.centromeres.fasta 
/homes/liu3zhen/local/bin/show-coords -clT -q  -I 90 -L 10000 $out.centromeres.delta >$out.cent.tmp.txt
less $out.cent.tmp.txt | awk '$10>0'|grep "]" -v| awk '{print $12"\t"$1"\t"$2}'|sort -k1,1 -k2,2n >$out.cent.bed

## gc contents to check mini cent.
bedtools getfasta -fi $ref -bed $bed -fo $bed.fasta
perl $sourcescript/gcCount.pl $bed.fasta |sed 's/:/	/g' | sed 's/-/	/g'|sort -k1,1 -k2,2n > $bed.fasta.gc.txt

module load R

Rscript --vanilla $sourcescript/plot.gc.content.R fa.size.txt $bed.fasta.gc.txt $ref.counts.txt $out.cent.bed $out.telomeres.hits.bed $out $refdb.18srDNA.min500bp.bed
#chrsize, GC counts, read counts, Cent, Telomeres, filename
