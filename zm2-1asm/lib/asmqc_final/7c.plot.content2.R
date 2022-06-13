#####develop later-01302021
### modified on 02042021


segplot.chr<-function(segfile="4b_geno3/4b2o_F2.geno.seg.filt.txt",
                      chrsizefile="/bulk/guifanglin/project/maize/reference/B73/B73ref4/chr.size.refgen4.txt",
                      chr.names=1:10, out.prefix="1o.seg.plot.B73Ref4", geno.code=c(1,2,3),geno.col=c("dark green","blue","red"),
                      out.fmt="pdf",width=5,height=3,cex.main=3,cex.axis = 2, cex.lab = 2){
  
  #read files
  geno.seg<-read.delim(segfile,stringsAsFactors = F)
  #geno.seg$Phenotype<-geno.seg$Individual
  
  geno.seg$CallusType<- gsub("_.*","",geno.seg$Individual)
  a<-geno.seg$CallusType[!duplicated(geno.seg$CallusType)]
  
  ##plot function
  seg.lines <- function(segdata, genocode, segcol, line.cex = 1) {
    eseg.geno <- segdata[segdata$Genotype == genocode, ]
    if (nrow(eseg.geno) > 0) {
      for (k in 1:nrow(eseg.geno)) {
        lines(x = eseg.geno[k, 3:4]/1000000, y = rep((shift+1), 2), lend = 2, cex = line.cex, col = segcol,lwd=line.cex) 
      }
    }
  }
  
  
  segm<-read.delim("/bulk/guifanglin/project/maize/A188-GM/GBS_F2_MT032017_MT022018_redo_2020/7-manuscript/main/seg/test/4b_geno3/4b2o_F2.geno.seg.filt.score.txt")
  segm$Marker<-paste0(segm$Chr,"_",segm$Pos)
  ajpeak<-read.delim("/bulk/guifanglin/project/maize/A188-GM/GBS_F2_MT032017_MT022018_redo_2020/7-manuscript/main/seg/peaks.adjust.txt")
  sig.m<-ajpeak$GBS_seg_marker
  
  
  ###plot by individuals
  ### plots for each individual
  chrsize <- read.delim(chrsizefile,stringsAsFactors = F, header=F)
  colnames(chrsize)<-c("Chr","Size")
  chrsize<-chrsize[chrsize$Chr %in% chr.names,]
  chrsize$Size<-as.numeric(chrsize$Size)
  
  for (j in 1:10) { # 10 chromosomes
    if (out.fmt=="pdf"){
      pdf(paste0(out.prefix, j, ".pdf"), width=width, height=height,  pointsize = 4)
    }
    if (out.fmt=="png"){
      png(paste0(out.prefix, j, ".png"),width=width, height=height,   pointsize = 4)
    }
    ####need to be edited
    
    if(j %in% ajpeak$Chromosome){
      m<-ajpeak[ajpeak$Chromosome==j,]$GBS_seg_marker
      test<-segm[segm$Marker==m,]
      x<-sort(as.vector(test[,-(1:5)]),decreasing = F)
      y<-names(x)
      
      s<-a[1]
      CallusType<- gsub("_.*","",y)
      allsamples<-y[CallusType==s]
      
    }else{
      
      s<-a[1]
      sgeno<-geno.seg[geno.seg$CallusType==s,]
      ssample<-sgeno[ !duplicated(sgeno$Individual),]
      allsamples<-ssample$Individual
    }       
    par(mar = c(0, 4, 4, 1),mfrow=c(2,1))
    
    plot(NULL,NULL, ylim=c(0, 1*length(allsamples)), xlim=c(0, 1.09*chrsize[chrsize$Chr==j,"Size"]/1000000),
         bty="n", type="n",yaxt="n",xaxt="n", cex.main=cex.main, main=paste0(out.prefix, j),
         xlab="", ylab="", cex.axis = cex.axis, cex.lab = cex.axis)
    legend(chrsize[chrsize$Chr==j,"Size"]/1000000*1.003,1.0*length(allsamples),legend = c("A188","B73","Hetero"),col = geno.col,lty=1, cex=0.8)
    
    count <- 0 
    for (esample in allsamples) {
      eseg<- geno.seg[geno.seg$Chr ==paste0("", j,"") & geno.seg$Individual == esample, ]
      
      shift <- 1 * count
      
      
      ### seg draw:
      
      seg.lines(segdata  = eseg, genocode = geno.code[1], segcol = geno.col[1], line.cex = 0.5*5)
      seg.lines(segdata  = eseg, genocode = geno.code[2], segcol = geno.col[2], line.cex = 0.5*5)
      seg.lines(segdata  = eseg, genocode = geno.code[3], segcol = geno.col[3],line.cex = 0.5*5)
      
      #axis(2, at =  shift, labels = "seg",pos=(1), cex.axis = 1,las=2,tick = F); # left side of axis
      
      count <- count + 1
      
    }
    ### label
    text(x = -10, y = 0.5*length(allsamples), labels = a[1], cex = 1, xpd = T)
    if(j %in% ajpeak$Chromosome){
      rect(xleft=ajpeak[ajpeak$Chromosome==j,"pm.start"]/1000000,ybottom = -3,ytop =1.02*length(allsamples),xright =ajpeak[ajpeak$Chromosome==j,"pm.end"]/1000000, lty = 2,border = "red",col = NA  )
      abline(v=ajpeak[ajpeak$Chromosome==j,"peak.pos"]/1000000,col="gray")
    }
    
    par(mar = c(4, 4, 0, 1))
    
    
    if(j %in% ajpeak$Chromosome){
      m<-ajpeak[ajpeak$Chromosome==j,]$GBS_seg_marker
      test<-segm[segm$Marker==m,]
      x<-sort(as.vector(test[,-(1:5)]),decreasing = F)
      y<-names(x)
      
      s<-a[2]
      CallusType<- gsub("_.*","",y)
      allsamples<-y[CallusType==s]
      
    }else{
      s<-a[2]
      sgeno<-geno.seg[geno.seg$CallusType==s,]
      ssample<-sgeno[ !duplicated(sgeno$Individual),]
      allsamples<-ssample$Individual
    } 
    plot(NULL,NULL, ylim=c(0, 1.01*length(allsamples)), xlim=c(0, 1.09*chrsize[chrsize$Chr==j,"Size"]/1000000),
         bty="n", type="n",yaxt="n", cex.main=cex.main, main="", 
         xlab="Physical coordinate (Mb)", ylab="", cex.axis = cex.axis, cex.lab = cex.axis)
    # legend(300,10,legend = geno.code,col = geno.col,lty=1, cex=0.8)
    
    count <- 0 
    
    for (esample in allsamples) {
      eseg<- geno.seg[geno.seg$Chr ==paste0("", j,"") & geno.seg$Individual == esample, ]
      
      shift <- 1 * count
      
      
      ### seg draw:
      
      seg.lines(segdata  = eseg, genocode = geno.code[1], segcol = geno.col[1], line.cex = 0.5*5)
      seg.lines(segdata  = eseg, genocode = geno.code[2], segcol = geno.col[2], line.cex = 0.5*5)
      seg.lines(segdata  = eseg, genocode = geno.code[3], segcol = geno.col[3],line.cex = 0.5*5)
      
      #axis(2, at =  shift, labels = "seg",pos=(1), cex.axis = 1,las=2,tick = F); # left side of axis
      
      ### label
      
      count <- count + 1
    }
    text(x = -10, y = 0.5*length(allsamples), labels = a[2], cex = 1, xpd = T)
    if(j %in% ajpeak$Chromosome){
      rect(xleft=ajpeak[ajpeak$Chromosome==j,"pm.start"]/1000000,ybottom = 0-1,ytop =1.1*length(allsamples),xright =ajpeak[ajpeak$Chromosome==j,"pm.end"]/1000000, lty = 2,border = "red",col = NA  )
      abline(v=ajpeak[ajpeak$Chromosome==j,"peak.pos"]/1000000,col="gray")
    }
    dev.off()
  }
  
}







