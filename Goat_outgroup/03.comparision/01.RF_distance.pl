#! /usr/bin/env perl
use strict;
use warnings;

`grep ";" prob.txt | cut -f1 > $0.inputTre`;

open R,"> $0.rscript";
print R '
library("phybase")
ml=read.tree("'.$0.'.inputTre")
nttree=read.tree(text="(((((bison,wisent),yak),(cattle,indicus)),buffalo),goat);")
mttree=read.tree(text="(((((cattle,indicus),wisent),(bison,yak)),buffalo),goat);")
dist=data.frame(nt=c(1:length(ml)),mt=c(1:length(ml)))
for(i in 1:length(ml))
{
    dist$tree[i]=write.tree(ml[i])
    dist$nt[i]=dist.topo(ml[i],nttree)
    dist$mt[i]=dist.topo(ml[i],mttree)
}
write.table(dist,file="'.$0.'.dist",quote=F,row.names=F)
  ';
close R;
print "Rscript $0.rscript\n";
