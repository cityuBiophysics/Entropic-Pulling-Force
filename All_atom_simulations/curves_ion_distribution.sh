for i in `seq 10001 60000`; do
  echo $i
  cp curves_twist_pdb/dnaMD$i.pdb dna.pdb
./../../../../../curves+/Cur+ <<!
&inp file=dna, lis=dnaout, sol=CE, ions=.t.,
 lib=../../../../../curves+/standard, &end
2 1 -1 0 0
1:25
50:26
!

awk  'NR>263{print $4 "\t" $5 "\t" $6}' dnaout.lis >> curves_ion.txt
rm dna*
done
