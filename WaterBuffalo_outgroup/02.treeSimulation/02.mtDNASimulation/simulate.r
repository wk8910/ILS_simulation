library(phybase)
mptree1 = "(buffalo:9.181489,(((indicus:1,cattle:1):1.181488,wisent:2.181488):0.000001,(bison:2.120149,yak:2.120149):0.061340):7.000000);"

spname <- species.name(mptree1)
nodematrix <- read.tree.nodes(str=mptree1, name=spname)$nodes
nodematrix[,5]<-2

genetrees=1:200000
for(i in 1:200000)
genetrees[i]<-sim.coaltree.sp(rootnode=11, nodematrix=nodematrix,nspecies=6,seq=rep(1,6), name=spname)$gt

write(genetrees,"wisent_simulated.tre")
