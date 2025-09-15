for i in `seq 1 60000`; do
  echo $i
  cp curves_twist_pdb/dnaMD$i.pdb dna.pdb
./../../../../../curves+/Cur+ <<!
&inp file=dna, lis=dnaout,
 lib=../../../../../curves+/standard, &end
2 1 -1 0 0
1:25
50:26
!
cut -c 18-30 dnaout.lis > c1.txt
cut -c 34-46 dnaout.lis > c2.txt
awk  '(NR>191 && NR<221){print $0}' c1.txt >> curves_minorgroove.txt
awk  '(NR>197 && NR<217){print $0}' c2.txt >> curves_majorgroove.txt
rm dna*
done
