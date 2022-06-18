#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)
#args
#args(names)
#genomesize without header
#setwd("~/gl_bulk/1-projects/2-wheatblast/1-TF05-1/1-asm/main/4_reorganize")
setwd(".")
options(scipen = 100) #disable scientif numbers notation; options(scipen = 0) to recover
#source("utils/gBin.R")
gBin<-function(filename,binsize=500,out){
  file<-read.delim(filename,stringsAsFactors = F,header = F)
  file<-file[order(file$V1),]
  dft<-data.frame()
  for (n in 1:nrow(file)){
    st<-seq(0,(file[n,2]-binsize),by = binsize)
    ed<-seq(binsize,(file[n,2]),by=binsize)
    chrname<-rep(file[n,1],length(st))
    df<-data.frame(chrname,st,ed)
    dft<-rbind(dft, df)
  }
  write.table(dft,file = out,quote = FALSE,sep="\t",row.names = F,col.names = F)
}

#infile="../../cache/4_np_reorganize/1ac_TF051mc7sp1np2020/1ac_TF051mc7sp1np2020.ro.1.fasta.size.txt"
#bs<-1000
#outfile="./test.txt"
#args[1]
#args[2]
#args[3]
#gBin(infile,bs,outfile)
gBin(args[1],binsize = as.numeric(args[2]),args[3])

