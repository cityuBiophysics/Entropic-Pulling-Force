 gmx insert-molecules -f box.gro -ci cohex.gro -o box_cohex.gro -nmol 16
 echo "COHEX               16" >> topol.top
 gmx solvate -cp box_cohex.gro -cs spc216.gro -o water.gro -p topol.top
 gmx grompp -f em.mdp -c water.gro -p topol.top -o ions.tpr -maxwarn 1
 echo 6 | gmx genion -s ions.tpr -o ion.gro -p topol.top  -nname CL -nn 0 -pname NA -np 0
 cp topol.top ion.top
