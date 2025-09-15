for i in `seq 1 60000`; do
        echo $i
        grep "P[[:space:]]\{4\}\|O1P\|O2P" curves_twist_pdb/dnaMD$i.pdb | grep 'ATOM' | cut -c 31-54  > a.txt
        cut -c 1-8   a.txt > a1.txt
        cut -c 9-16   a.txt > a2.txt
        cut -c 17-24   a.txt > a3.txt
        paste -d ' ' a1.txt a2.txt > a4.txt
        paste -d ' ' a4.txt a3.txt >> phosphate_position.txt
done
