FNR==NR{
  a[$1]=$2
  next
i++}
{ if ($1 in a) {print $1 "\t" $2 "\t" a[$1]}}
