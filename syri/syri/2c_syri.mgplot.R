setwd("/bulk/liu3zhen/research/projects/panMoGenome/main/01_Zambia/01b_syri/1b5_mgplot/")

source("/homes/liu3zhen/scripts2/cgplot/mgplot.R")

# SYRI meta data
srlist_core <- "2i_syri.mg4core.meta"
pdfdir <- "2o_pdf"
system(paste("mkdir", pdfdir))

# core chromosomes:
cores <- paste0("chr", 1:7)
for (chr in cores) {
  outfile <- paste0(pdfdir, "/", chr, ".pdf")
  mgplot(srlist=srlist_core, chr=chr, add2existingplot=F,
         min.syn.size=10000, min.others.size=10000,
         genome.name.space=0.15, genome.label.col="palevioletred4",
         chr.col="gray80", chr.height.prop=0.025,
         main=chr, main.pos=NULL, main.label.col="palevioletred4",
         band.legend.add=T, band.legend.space.prop=0.1, band.legend.xpos=0.45,
         outpdf=T, outfile=outfile, pdfwidth=6, pdfheight=4)   
}

# mini-chromosome
srlist_mini <- "2i_syri.mg4mini.meta"
outfile <- paste0(pdfdir, "/mini.pdf")
chr <- "mini"
mgplot(srlist=srlist_mini, chr=chr, add2existingplot=F,
       min.syn.size=10000, min.others.size=10000,
       genome.name.space=0.15, genome.label.col="palevioletred4",
       chr.col="gray80", chr.height.prop=0.025,
       main=chr, main.pos=NULL, main.label.col="palevioletred4",
       band.legend.add=T, band.legend.space.prop=0.1, band.legend.xpos=0.45,
       outpdf=T, outfile=outfile, pdfwidth=6, pdfheight=5)
