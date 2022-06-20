FNR==NR{
  a[$1]=$2
  next
i}
{ if ($2 in a) {print $1, a[$2], $3, $4, $5, $6}else {print $1, $2, $3, $4, $5, $6}}

