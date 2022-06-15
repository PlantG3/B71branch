#!/bin/bash -l
#SBATCH --mem-per-cpu=60G
#SBATCH --time=1-00:00:00
#SBATCH --cpus-per-task=1

module load Java/1.8.0_192

# generate a bam list
vcf=1o_SunDec261225092021/1o.vcf
ref=/homes/liu3zhen/references/fungi/magnaporthe/B71Ref2/genome/gatk/B71Ref2.fasta
out=Mo
gatk SelectVariants \
	-R $ref \
	-V $vcf \
	-select 'DP >= 500' \
	-select 'DP <= 50000' \
	--restrict-alleles-to BIALLELIC \
	-O ${out}.1.vcf &>${out}.1.log

# B71 matches REF
perl ~/scripts2/vcfbox/vcfbox.pl genomatch \
	-t "B71-1,B71-2" -g "0,0" \
	-o ${out}.2.B71eqREF.vcf \
	${out}.1.vcf


