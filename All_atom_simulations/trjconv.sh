echo q > tmpq
gmx make_ndx -f em.gro -o < tmpq
echo [ center ] >> index.ndx
echo 395 >> index.ndx
echo 1 > tmp1
gmx trjconv -f traj.xtc -s md.tpr -n -o traj2.xtc -pbc whole -dt 10 < tmp1
echo 14 > tmpb
echo 1 >> tmpb
gmx trjconv -f traj2.xtc -s md.tpr -n -o traj3.xtc -pbc atom -center < tmpb
mkdir curves_twist_pdb/
echo 1 | gmx trjconv -f traj3.xtc -s md.tpr -n -o ./curves_twist_pdb/dnaMD.pdb -sep
mkdir curves_twist_analysis/
mv curves_twist_pdb/ curves_twist_analysis/
rm "#"*
