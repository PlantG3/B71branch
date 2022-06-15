in=ZM2-1.v0.3
out=ZM2-1.v0.32

rm ../results/$out.fasta 
seqname=$(grep ">" ../cache/8o-pilon/$in.np2.pilon2.fasta |sed 's/>//g'|sort)
for seq in $seqname
do
echo $seq >tmp
perl -ne 'if(/^>(\S+)/){$c=$i{$1}}$c?print:chomp;$i{$_}=1 if @ARGV' tmp ../cache/8o-pilon/$in.np2.pilon2.fasta >>../results/$out.fasta 
done
rm tmp
#remove this code if tig number more than 100
#sed -i 's/tig00/tig/g' ../results/$out.fasta 
