module load SAMtools
samtools view zm1-2ont2probe.filter.bam|awk '{print $1,$6}'> zm1-2ont2probe.read.filter.list.txt
list=`awk '{print$2}' zm1-2ont2probe.read.filter.list.txt`

row=0
rm *.tmp
for i in $list
do
row=`echo $row + 1|bc`
out=`echo $i| sed 's/M/\n/g'|sed 's/[[:digit:]]\+[DIS]//g'|sort|awk '{total=total +$1}END{print total}'` 
echo $out >>match.number.tmp
awk -v row=$row 'FNR==row {print $1}' zm1-2ont2probe.read.filter.list.txt >>match.read.name.tmp

done

paste match.read.name.txt match.number.txt |awk '$2 >19000' |awk '{print $1}' >read.to.extract.txt

samtools view -H zm1-2ont2probe.filter.bam >zm1-2ont2probe.filter.filter.sam
samtools view zm1-2ont2probe.filter.bam |grep -f read.to.extract.txt >>zm1-2ont2probe.filter.filter.sam
samtools view -b zm1-2ont2probe.filter.filter.sam| samtools sort -o zm1-2ont2probe.filter.filter.bam
samtools index zm1-2ont2probe.filter.filter.bam


rm *.tmp
