library(tidyverse)
library(plotly)
library(DT)

### exercise 1
SNPs<- read.table("23andMe_complete.txt", header = TRUE, sep = "\t")
p<- ggplot(SNPs,aes(chromosome)) +
  geom_bar(fill = "blue") +
  ggtitle("Total SNPs for each chromosome") +
  ylab("Total number of SNPs") +
  xlab("Chromosome")
p

### exercise 2
mycolor<-c("AA"="blue", "AC"="blue", "AG"="blue", "AT"="blue", "CC"="blue", "CG"="blue", "CT"="blue", "GG"="blue", "GT"="blue", "TT"="blue","A"="pink", "C"="pink", "G"="pink", "T"="pink", "D"="orange", "DD"="orange", "DI"="orange","I"="orange","II"="orange","--"="green")
ggplot(SNPs, aes(chromosome, fill = genotype))+
  geom_bar(color = "black")+
  ggtitle("Total genotype count for each chromosome")+
  ylab("Genotype count")+
  xlab("Chromosome")+
  scale_fill_manual(values=c(mycolor))

### exercise 3
ppi <- 300
png("ex3_plot", width=6*ppi, height=6*ppi, res=ppi)
ggplot(data = SNPs, aes(chromosome, fill = genotype)) + 
  geom_bar(position = "dodge")
dev.off()

![Genotype counts per chromosome](ex3_plot) 

### exercise 4
ggplot(SNPs, aes(chromosome, fill = genotype))+
  geom_bar(position = "dodge")+ 
  ggtitle("SNP count of each genotype for each chromosome")+
  ylab("SNP count")+
  xlab("Chromosome")+
  facet_wrap(~genotype)

### exercise 5
p <- ggplot(SNPs, aes(chromosome, fill = genotype))+
  geom_bar(position = "dodge")+ 
  facet_wrap(~genotype)
ggplotly(p)

### exercise 6
chromosome_subset <- subset(SNPs, chromosome == "Y")
datatable(chromosome_subset)