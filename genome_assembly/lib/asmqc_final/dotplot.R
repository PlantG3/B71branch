setwd("/bulk/guifanglin/project/3-wheatblast/11-asm.compare-032020/1-dotplot/")
source("/homes/huakun/TF05-1/1-mini-illumina-predict-blast-100819/dotblot/nucmer.twosets.plot.R")
datapath <- "."


####plot1
deltafile <- "1o.B71Ref1.5.2.TF05-1-MC7-canu1.9-v0.9.delta"
cat(deltafile, "\n")
x<-"B71Ref1.5"
y<-"TF05-1-MC7-canu1.9-v0.9"
min.match<-100000
min.ID<-90
nucmer.twosets.plot(datapath=datapath, datafile=deltafile,
                    lend.turnoff=T,
                    aln.min.size=min.match, aln.min.identity=min.ID,
                    xlab = x, ylab = y,
                    main = paste0(x, " vs. ", y),
                    line.width.factor=2, xlabel.rm = "tig", ylabel.rm = "tig",
                    tableout=T, pdfout=T, outpath=".",
                    pdf.width = 4.9, pdf.height = 5,
                    tableoutfile=paste0("2o-",x,"vs",y,".txt"),
                    imageoutfile=paste0("2o-",x,"vs",y,".pdf"))


####plot2
deltafile <- "1o.TF05-1mini1-scafID.2.B71ONTv0.1np1.delta"
cat(deltafile, "\n")
x<-"TF05-1mini1"
y<-"B71ONTv0.1"
min.match<-1000
min.ID<-90
nucmer.twosets.plot(datapath=datapath, datafile=deltafile,
                    lend.turnoff=T,
                    aln.min.size=min.match, aln.min.identity=min.ID,
                    xlab = x, ylab = y,
                    main = paste0(x, " vs. ", y),
                    line.width.factor=2, xlabel.rm = "tig", ylabel.rm = "tig",
                    tableout=T, pdfout=T, outpath=".",
                    pdf.width = 4.9, pdf.height = 5,
                    tableoutfile=paste0("2o-",x,"vs",y,".txt"),
                    imageoutfile=paste0("2o-",x,"vs",y,".pdf"))

####plot3
deltafile <- "1o.TF05-1mini1-scafID.2.B71Ref1.fas.delta"
cat(deltafile, "\n")
x<-"TF05-1mini1"
y<-"B71Ref1"
min.match<-1000
min.ID<-90
nucmer.twosets.plot(datapath=datapath, datafile=deltafile,
                    lend.turnoff=T,
                    aln.min.size=min.match, aln.min.identity=min.ID,
                    xlab = x, ylab = y,
                    main = paste0(x, " vs. ", y),
                    line.width.factor=2, xlabel.rm = "tig", ylabel.rm = "tig",
                    tableout=T, pdfout=T, outpath=".",
                    pdf.width = 4.9, pdf.height = 5,
                    tableoutfile=paste0("2o-",x,"vs",y,".txt"),
                    imageoutfile=paste0("2o-",x,"vs",y,".pdf"))

####plot4
deltafile <- "1o.TF05-1mini2-scafID.2.B71ONTv0.1np1.delta"
cat(deltafile, "\n")
x<-"TF05-1mini2"
y<-"B71ONTv0.1"
min.match<-1000
min.ID<-90
nucmer.twosets.plot(datapath=datapath, datafile=deltafile,
                    lend.turnoff=T,
                    aln.min.size=min.match, aln.min.identity=min.ID,
                    xlab = x, ylab = y,
                    main = paste0(x, " vs. ", y),
                    line.width.factor=2, xlabel.rm = "tig", ylabel.rm = "tig",
                    tableout=T, pdfout=T, outpath=".",
                    pdf.width = 4.9, pdf.height = 5,
                    tableoutfile=paste0("2o-",x,"vs",y,".txt"),
                    imageoutfile=paste0("2o-",x,"vs",y,".pdf"))

####plot5
deltafile <- "1o.TF05-1mini2-scafID.2.B71Ref1.fas.delta"
cat(deltafile, "\n")
x<-"TF05-1mini2"
y<-"B71Ref1"
min.match<-1000
min.ID<-90
nucmer.twosets.plot(datapath=datapath, datafile=deltafile,
                    lend.turnoff=T,
                    aln.min.size=min.match, aln.min.identity=min.ID,
                    xlab = x, ylab = y,
                    main = paste0(x, " vs. ", y),
                    line.width.factor=2, xlabel.rm = "tig", ylabel.rm = "tig",
                    tableout=T, pdfout=T, outpath=".",
                    pdf.width = 4.9, pdf.height = 5,
                    tableoutfile=paste0("2o-",x,"vs",y,".txt"),
                    imageoutfile=paste0("2o-",x,"vs",y,".pdf"))


####plot6
  deltafile <- "1o.TF05-1mini12-scafID.2.B71ONTv0.1np1.delta"
cat(deltafile, "\n")
x<-"TF05-1mini12"
y<-"B71ONTv0.1"
min.match<-1000
min.ID<-90
nucmer.twosets.plot(datapath=datapath, datafile=deltafile,
                    lend.turnoff=T,
                    aln.min.size=min.match, aln.min.identity=min.ID,
                    xlab = x, ylab = y,
                    main = paste0(x, " vs. ", y),
                    line.width.factor=2, xlabel.rm = "tig", ylabel.rm = "tig",
                    tableout=T, pdfout=T, outpath=".",
                    pdf.width = 4.9, pdf.height = 5,
                    tableoutfile=paste0("2o-",x,"vs",y,".txt"),
                    imageoutfile=paste0("2o-",x,"vs",y,".pdf"))

####plot7
deltafile <- "1o.TF05-1mini12-scafID.2.B71Ref1.fas.delta"
cat(deltafile, "\n")
x<-"TF05-1mini12"
y<-"B71Ref1"
min.match<-1000
min.ID<-90
nucmer.twosets.plot(datapath=datapath, datafile=deltafile,
                    lend.turnoff=T,
                    aln.min.size=min.match, aln.min.identity=min.ID,
                    xlab = x, ylab = y,
                    main = paste0(x, " vs. ", y),
                    line.width.factor=2, xlabel.rm = "tig", ylabel.rm = "tig",
                    tableout=T, pdfout=T, outpath=".",
                    pdf.width = 4.9, pdf.height = 5,
                    tableoutfile=paste0("2o-",x,"vs",y,".txt"),
                    imageoutfile=paste0("2o-",x,"vs",y,".pdf"))


####plot8
deltafile <- "1o.TF05-1core-scafID.2.B71ONTv0.1np1.delta"
cat(deltafile, "\n")
x<-"TF05-1mini1"
y<-"B71ONTv0.1"
min.match<-50000
min.ID<-90
nucmer.twosets.plot(datapath=datapath, datafile=deltafile,
                    lend.turnoff=T,
                    aln.min.size=min.match, aln.min.identity=min.ID,
                    xlab = x, ylab = y,
                    main = paste0(x, " vs. ", y),
                    line.width.factor=2, xlabel.rm = "tig", ylabel.rm = "tig",
                    tableout=T, pdfout=T, outpath=".",
                    pdf.width = 4.9, pdf.height = 5,
                    tableoutfile=paste0("2o-",x,"vs",y,".txt"),
                    imageoutfile=paste0("2o-",x,"vs",y,".pdf"))

####plot9
deltafile <- "1o.TF05-1core-scafID.2.B71Ref1.fas.delta"
cat(deltafile, "\n")
x<-"TF05-1core"
y<-"B71Ref1"
min.match<-50000
min.ID<-90
nucmer.twosets.plot(datapath=datapath, datafile=deltafile,
                    lend.turnoff=T,
                    aln.min.size=min.match, aln.min.identity=min.ID,
                    xlab = x, ylab = y,
                    main = paste0(x, " vs. ", y),
                    line.width.factor=2, xlabel.rm = "tig", ylabel.rm = "tig",
                    tableout=T, pdfout=T, outpath=".",
                    pdf.width = 4.9, pdf.height = 5,
                    tableoutfile=paste0("2o-",x,"vs",y,".txt"),
                    imageoutfile=paste0("2o-",x,"vs",y,".pdf"))


