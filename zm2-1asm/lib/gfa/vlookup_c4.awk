FNR==NR{
  a[$1]=$2
  next
i++}
{ if ($4 in a) {print $1 "\t" $2 "\t" $3 "\t" a[$4] "\t" $5 "\t" $6}else {print $1 "\t" $2 "\t" $3 "\t" $4 "\t" $5 "\t" $6}}

