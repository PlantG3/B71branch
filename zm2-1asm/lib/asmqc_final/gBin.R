options(scipen = 100)
gBin<-function(filename,binsize=500,out="out.txt"){
  file<-read.delim(filename,stringsAsFactors = F,header = F)
  file<-file[order(file$V1),]
  dft<-data.frame()
  for (n in 1:nrow(file)){
    st<-seq(1,(file[n,2]-binsize),by = binsize)
    ed<-seq(binsize,(file[n,2]),by=binsize)
    chrname<-rep(file[n,1],length(st))
    df<-data.frame(chrname,st,ed)
    dft<-rbind(dft, df)
  }
  write.table(dft,file = out,quote = FALSE,sep="\t",row.names = F,col.names = F)
}
