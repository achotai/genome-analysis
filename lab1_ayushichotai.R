# Basic computation

# example 1
3*3

# example 2
3+3/3

# example 3
(3+3)/3

# example 4: Natural logarithm with base e=2.718282
log(10)

# example 5: exponential function
exp(2)

# example 6: 3 raised to the third power
3^3

# example 7: Square root
sqrt(9)

# example 8: Absolute value of 1-7
abs(1-7)


# R data types

# Numerics
x=3.5

# example 1
x

# example 2
sqrt(x)

# Integers

# example 1
x=3.33
y=as.integer(x)
y

# Logical

#example 1
x=1; y=2
z=x>y
z

#standard logical operations 

# example 1
x=TRUE; y=FALSE 
x & y

# example 2
x|y 

# example 3
!x

# Character
x="ATGAAA"
y="TTTTGA"

# example 1
x

# example 2
DNA = paste(x,y)
DNA

# Complex
x = 1 + 2i 

# example 1
x

#Vectors
x<-c(1,10,100)    

# example 1
x

# example 2
x*2

# example 3
sum(x)

# example 4: arithmatic
x<- c(1,10,100) 
y<- c(1,2,3) 

x * y

# example 5: characters
codons<-c("AUG", "UAU", "UGA") 
codons

# Simple Graphs
RNA_levels<-c(7, 28, 100, 201, 208)

# example 1: simple bar plot
barplot(RNA_levels)


# Exercises

# exercise 1
x=2
y=8

# sum
x+y

# difference
x-y

# product
x*y

# quotient
x/y

# exercise 2
x=3.5
y=5

x^5>y^4

# exercise 3
# vector
x<- c(211, 62, 108, 43, 129)
x

# sum of vector
sum(x)

# related frequency
x/sum(x)

# exercise 4
nucleotides<- c("A", "T", "C", "G")

sort(nucleotides)
