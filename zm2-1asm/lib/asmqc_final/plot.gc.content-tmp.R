#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)

#Rscript --vanilla $sourcescript/7c.plot.content.R $filename.ro.1.fasta.size.txt $bed.fasta.gc.txt 4o.$filename.ro.1.counts.txt $ref.cent.bed $ref.telomeres.hits.bed $filename.ro.1
#chrsize, GC counts, read counts, Cent, Telomeres, filename, MoTER1
args
chrsize<-read.delim(args[1],header = F)
chrsize<-chrsize[order(chrsize$V1),]
chrsize<-chrsize[chrsize$V1!="mt",]
gc<-read.delim(args[2],header = F)
#readc<-read.delim(args[3],header = F)
cent<-read.delim(args[4],header = F)
telo<-read.delim(args[5],header = F)
outpre<-args[6]
moter1<-read.delim(args[7],header = F)
##
#chrsize<-read.delim("/bulk/guifanglin/1-projects/2-wheatblast/1-TF05-1/1-asm/cache/4_np_reorganize/1ac_TF051mc7sp1np2020/1ac_TF051mc7sp1np2020.ro.1.fasta.size.txt",header = F)
#gc<-read.delim("/bulk/guifanglin/1-projects/2-wheatblast/1-TF05-1/1-asm/cache/4_np_reorganize/1ac_TF051mc7sp1np2020/1ac_TF051mc7sp1np2020.ro.1.fasta.size.bin.300.bed.fasta.gc.txt",header = F)
#readc<-read.delim("/bulk/guifanglin/1-projects/2-wheatblast/1-TF05-1/1-asm/cache/4_np_reorganize/1ac_TF051mc7sp1np2020/4o.1ac_TF051mc7sp1np2020.ro.1.counts.txt",header = F)
#cent<-read.delim("/bulk/guifanglin/1-projects/2-wheatblast/1-TF05-1/1-asm/cache/4_np_reorganize/1ac_TF051mc7sp1np2020/1ac_TF051mc7sp1np2020.ro.1.fasta.cent.bed",header = F)
#telo<-read.delim("/bulk/guifanglin/1-projects/2-wheatblast/1-TF05-1/1-asm/cache/4_np_reorganize/1ac_TF051mc7sp1np2020/1ac_TF051mc7sp1np2020.ro.1.fasta.telomeres.hits.bed",header = F)
#moter1<-read.delim("/bulk/guifanglin/1-projects/2-wheatblast/1-TF05-1/1-asm/cache/4_np_reorganize/1ac_TF051mc7sp1np2020/6o.1ac_TF051mc7sp1np2020.ro.1.MoTER1RT.min500bp.bed",header=F)
#outpre<-"1ac_TF051mc7sp1np2020.ro.1"
  
  #GC content
pdf(paste0("6o-",outpre,".gc.pdf"), width=12, height=8)
yrange=c(0, (nrow(chrsize)*3.5))
xrange=c(0, max(chrsize$V2))
ylab.text="GC count"

plot(NULL, NULL, ylim = yrange, xlim = xrange,
     xlab = "physical coordinate (bp)", ylab = ylab.text, yaxt="n",
     main = paste0(outpre,".GC content"), 
     bty = "n")
  legend(max(chrsize$V2)-3000000,3.5*2, legend=c("centromere", "telomere","MoTER1"),
       col=c("red", "blue","purple"), pch =c(23,25,2), cex=0.8)

s<-nrow(chrsize)*3.5

# background
for (i in 1:nrow(chrsize)){
  lab<-gsub("tig000000","tig",chrsize[i,1])
  rect(0,s-3,chrsize[i,2],s,border = T)
  lines(x=c(0,chrsize[i,2]),y=c(s-3*0.3,s-3*0.3),lty=2,cex=0.01)
  lines(x=c(0,chrsize[i,2]),y=c(s-3*0.7,s-3*0.7),lty=2,cex=0.01)
  axis(2, at=s-1,labels =lab,cex=0.1)
  s<-s-3.5
}

# data
s<-nrow(chrsize)*3.5
#i=1
i=3
for (i in 1:nrow(chrsize)){
  a<-gc[gc$V1==chrsize[i,1],]
  b<-cent[cent$V1==chrsize[i,1],]
  c<-telo[telo$V1==chrsize[i,1],]
  d<-moter1[moter1$V1==chrsize[i,1],]
  #points(x=a$V2+150,y=s-3+a$V4*3*0.01,cex=0.01,col="grey50")
  for (j in 1:(nrow(a)-1)){
    lines(x=c(a[j,2],a[j+1,2]),y=c(s-3+0.03*a[j,4],s-3+0.03*a[j+1,4]),cex=0.01,col="grey30")
  }
  if (length(b)!=0){
  points(b$V2,rep(s-3*0.1,length(b$V2)),col="red", pch=23,cex=1) #bg="red",
  }
  
  if (length(c)!=0){
  points(c$V2,rep(s-3*0.1,length(c$V2)),col="blue", pch=25,cex=1) #bg="red",
  }
  
  if (length(d)!=0){
    points(d$V2,rep(s-3.5+3*0.3,length(d$V2)),col="purple", pch=2,cex=1) #bg="red",
  }
  s<-s-3.5
                          }

dev.off()


