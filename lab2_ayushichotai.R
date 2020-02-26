# basic data objects

# vectors
# example 1
SNPs <- c("AA", "AA", "GG", "AG", "AG", "AA","AG", "AA", "AA", "AA", "AG")
SNPs

# factors
# example 1
SNPs_cat <- factor(SNPs)
SNPs_cat

# example 2
table(SNPs_cat)

plot(SNPs_cat)

# example 3
as.numeric(SNPs_cat)

# matrices
# example 1
Day1 <- c(2,4,6,8)
Day2 <- c(3,6,9,12)
Day3 <- c(1,4,9,16)
A <- cbind(Day1,Day2,Day3)
A

# example 2
Day1 <- c(2,4,6,8)
Day2 <- c(3,6,9,12)
Day3 <- c(1,4,9,16)
B <- rbind(Day1,Day2,Day3)
B

# example 3
Day4 <- c(5,10,11,20)
C <- rbind(B,Day4)
C

# example 4
A * 10

# example 5
A[1]

# example 6
A[12]

# example 7
A[ ,c(1,3)]

# example 8
A[c(2,4), ]

# example 9
t(A)

# data frames

Gene1 <- c(2,4,6,8)
Gene2 <- c(3,6,9,12)
Gene3 <- c(1,4,9,16)
Gene <- c("Day 1", "Day 2","Day 3", "Day 4")
RNAseq <- data.frame(Gene1, Gene2, Gene3, row.names = Gene)
RNAseq

# example 1
RNAseq$Gene3

# example 2
plot(RNAseq$Gene1,RNAseq$Gene3)

# example 3
plot(RNAseq$Day,RNAseq$Gene3)

# example 4
RNAseq$Gene4 <- c(5, 10, 15, 20)
RNAseq

# example 5
RNAseq[,"Gene5"] <- c(1, 2, 3, 3)
RNAseq

# example 6
RNAseq["Day 4",] <- rbind(10, 14, 20, 22, 3)

# checking on object types

# example 1
x = 1
str(x)

# example 2
a = "ATGCCCTGA"
str(a)

# example 3
str(SNPs)

# example 4
SNPs <- c("AA", "AA", "GG", "AG", "AG", "AA","AG", "AA", "AA", "AA", "AG")
str(SNPs_cat)

# example 5
Day1 <- c(2,4,6,8)
Day2 <- c(3,6,9,12)
Day3 <- c(1,4,9,16)
B <- rbind(Day1,Day2,Day3)
str (B)

# example 6
Gene1 <- c(2,4,6,8)
Gene2 <- c(3,6,9,12)
Gene3 <- c(1,4,9,16)
Gene <- c("Day 1", "Day 2","Day 3", "Day 4")
RNAseq <- data.frame(Gene1, Gene2, Gene3, row.names = Gene)
str(RNAseq)

# importing data

# loading a truncated 23andMe file

SNP_table <- read.table("23andMe_example_cat25.txt", header = TRUE, sep = "\t")
SNP_table

# getting information on a dataset

# example 1
names(SNP_table)

# example 2
str(SNP_table)

# list levels of factor genotype
levels(SNP_table$genotype)

# dimensions of an object
dim(SNP_table)

# class of an object
class(SNP_table)

# print mydata
SNP_table

# print first 5 rows of the data set
head(SNP_table, n=10)

# print last 5 rows of the data set
tail(SNP_table, n=5)

# example 1
SNP_table$chromosome <- as.factor(SNP_table$chromosome)
str(SNP_table) 

# example 2
SNP_table$chromosome <- as.integer(SNP_table$chromosome)
str(SNP_table) 

# example 3
SNP_table_AG <- subset(SNP_table, genotype == 'AG') 
SNP_table_AG

# example 4
table(SNP_table_AG$chromosome)

# example 5
subset(SNP_table, position > 700000 & position < 800000)

# exercises

# exercise 1
x<- c (1, 3, 6, 9, 12)
y<- c (1, 0, 1, 0, 1)

# addition
x+y

# subtract
x-y

# multiply
x*y

# divide
x/y

# exercise 2
A<- c (0, 1, 2, 3)
B<- c ("aa", "bb", "cc", "dd")
C<- c ("aa", 1, "bb", 2)

str(A)
str(B)
str(C)

# exercise 3

# visualizing the matrix
genotype1<- c("AA", "AA", "AG", "GG", "GG")
genotype2<- c("AA", "AA", "GG", "GG", "GG")
A<- cbind(genotype1, genotype2)
A

# table
table(genotype1)
table(genotype2)

# exercise 4
treatment1 <- c(0, 1, 2, 3, 4)
treatment2 <- c(0, 2, 4, 6, 8)
treatment3 <- c(0, 3, 6, 9, 12)
time <- c(0, 2, 4, 6, 8)

treatment <- data.frame(treatment1, treatment2, treatment3, row.names = times)
treatment

treatment$times <- c(0, 2, 4, 6, 8)
treatment

plot(treatment$treatment3, treatment$times)

# exercise 5

SNP_table <- read.table("23andMe_complete.txt", header = TRUE, sep = "\t")

str(SNP_table)

# This chromosome is shown to be a factor.
# The truncated version shows that it is integers, meaning that it has no characters. However, in this file, there are characters present, implying that there is a mix between numbers and characters or it has only characters.

# exercise 6

table(SNP_table$genotype)

# exercise 7

SNP_table_A <- subset(SNP_table, genotype == 'A')
table(SNP_table_A$chromosome)

