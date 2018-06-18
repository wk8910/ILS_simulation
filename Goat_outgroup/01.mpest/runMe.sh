perl generate_control_file.pl gene.tre > mpest.ctl
~/software/MP-EST/mpest_2.0/src/mpest mpest.ctl
mv gene.tre_besttree.tre mpest.out
perl convertNEXUS2newick.pl mpest.out
perl unifyTreeLength.pl mpest.out.nwk
rm -f mpest.out.nwk
mv mpest.out.nwk.regular.tre mpest.out.tre
