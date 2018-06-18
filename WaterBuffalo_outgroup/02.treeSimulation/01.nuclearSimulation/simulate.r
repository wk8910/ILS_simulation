library(phybase)
mptree1 = "(buffalo:9.181499,((yak:1.905599,(bison:1.014857,wisent:1.014857):0.890742):0.275900,(cattle:1,indicus:1):1.181499):7.000000);"

spname <- species.name(mptree1)
nodematrix <- read.tree.nodes(str=mptree1, name=spname)$nodes
nodematrix[,5]<-2

genetrees=1:200000
for(i in 1:200000)
genetrees[i]<-sim.coaltree.sp(rootnode=11, nodematrix=nodematrix,nspecies=6,seq=rep(1,6), name=spname)$gt

write(genetrees,"wisent_simulated.tre")
