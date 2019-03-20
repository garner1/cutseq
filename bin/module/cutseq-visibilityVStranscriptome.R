library(SparseM)
library(futile.matrix)

rows <- c(1:20521)
cols <- c(1:1218)

m <- read.matrix("/home/garner1/Work/dataset/bioinf.iasi.cnr.it/bed/brca/rnaseqv2/gene.quantification/bedfiles/sorted/positions/sparse/geneXcase.cutseq.sparse", row.ids=rows, col.ids=cols)
r <- rowSums(m) #sum over patients for better visualization
smoothScatter(r,main="TCGA-BRCA expression of CUTseq most visible genes",xlab="rank of the gene expression", ylab="number of cases")

m2 <- read.matrix("/home/garner1/Work/dataset/bioinf.iasi.cnr.it/bed/brca/rnaseqv2/gene.quantification/bedfiles/sorted/positions/sparse/geneXcase.random.sparse", row.ids=rows, col.ids=cols)
r2 <- rowSums(m2) #sum over patients for better visualization
smoothScatter(r2,main="TCGA-BRCA expression of a random set of genes",xlab="rank of the gene expression", ylab="number of cases",ylim=c(0,150))

# image(as.matrix.csr(m)) #plot the sparse matrix
