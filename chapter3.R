#####
# CHAPTER 3: MATRICES AND ARRAYS
# The Art of R Programming, by Norman Matloff
#
# Focus of this chapter: Matrix operations, particularly those analogous to vector subsetting and vectorization. 
# Also some discussion of higher-dimensional arrays. 

#####
# 3.1: Creating Matrices

#Matrix row and column subscripts begin with 1
#The internal storage is column-major order, meaning that first all of column 1 is stored, then 2, and so on. 

#One way to create a matrix is to use the matrix() function:
y <- matrix(c(1,2,3,4), nrow=2, ncol=2)
y
y <- matrix(c(1,2,3,4), nrow=2)
y
y[,2]
#we can also fill it in after, but we do need to specify that y will be a 2x2 matrix first
y <- matrix(nrow=2, ncol=2)
y[1,1] <- 1
y[2,1] <- 2
y[1,2] <- 3
y[2,2] <- 4
y

# Though the internal storage is column-order, you can set the byrow argument in matrix() to true to indicate the data is coming in row-major order
m <- matrix(c(1,2,3,4,5,6), nrow=2, byrow=T)
m
# Note that it is still stored internally in column-major order

#####
# 3.2: General Matrix Operations
# We'll take a look at some common operations performed with matrices. 

#3.2.1 Performing Linear Algebra Operations on Matrices
# Some examples of matrix multiplication, scalar multiplication, and addition
y <- matrix(c(1,2,3,4), nrow=2)
y %*% y # mathematical matrix multiplication
3*y #mathematical multiplication of matrix by scalar
y+y #mathematical matrix addition

# Section 8.4 has more about linear algebra operations on matrices. 

# 3.2.2 Matrix Indexing
#So the same operations discussed for vectors in 2.4.2 apply to matrices as well. 
#Here's an example:
z <- matrix(c(1,2,3,4,1,1,0,0,1,0,1,0), nrow=4)
z
z[,2:3]  #extracting submatrix containing all elements in columns 2 and 3 

#we can also extract certain rows:
y <- matrix(c(11,21,31, 12,22,32), nrow=3)
y
y[2:3,]
y[2:3,2]

# you can also assign values to submatrices:
y <- matrix(c(1,2,3,4,5,6), nrow=3)
y
y[c(1,3),] <- matrix(c(1,1,8,12), nrow=2)  #assign new values to the first and third rows of y
y

#another example of assignment to submatrices:
x <- matrix(nrow=3, ncol=3)
y <- matrix(c(4,5,2,3), nrow=2)
y
x[2:3, 2:3] <- y
x

# negative subscripts, used with vectors to exclude certain elements, work the same way with matrices:
y <- matrix(c(1,2,3,4,5,6), nrow=3)
y[-2,] #means we want all rows of y except the second


#3.2.3 Extended Example: Image Manipulation
# Excluded again because specifics hard to match 

# 3.2.4 Filtering on Matrices
# Filtering can be done with matriecs just as is done with vectors. Must be careful with the syntax though. 
# Start with a simple example:
x <- matrix( c(1,2,3,2,3,4), nrow=3)
x
x[x[,2] >= 3,]

# let's break it down to understand things a little better
j <- x[,2] >= 3
j
x[j,]

# for performance purposes, it's worth noting that the computation of j here is a completely vectorized operation

#here is another example, using the same x:
#(what is z? I made it up to get the correct results)
z <- c(1,2,3)
x[z%% 2 == 1,]

#Here is another example:
m <- matrix(c(1,2,3,4,5,6), nrow=3)
m
m[m[,1] > 1 & m[,2] > 5,]

#And since matrices are vectors, you can also apply vector operations to them. For example:

m <- matrix(c(5,2,9,-1,10,11), nrow=3)
m
which(m>2)


#3.2.5 Extended Example: Generating a Covariance Matrix
# This example demonstrates the row() and col() functions, whose arguments are matrices
#for example, for a matrix a, row(a[2,8]) will return the row number of that element of a, which is 2.
#It is omitted. Useful to read through in the book though. 


#####
# 3.3: Applying functions to Matrix Rows and Columns

# The *apply family of functions is one of the most famous and most used features of R

#3.3.1 Using the apply() function
# General form of apply for matrices: apply(m, dimcode, f, fargs)

#For example, here we apply the R function mean() to each column of a matrix z:
z <- matrix(c(1,2,3,4,5,6), nrow=3)
z
apply(z,2,mean)

#can also use apply with a function you write yourself, for example:
f <- function(x) x/c(2,8)
y <- apply(z,1,f)
y

#the transpose function t() can be useful to swap rows and cols:
t(apply(z,1,f))

#an example of a matrix function that produces a vector as a result
copymaj <- function(rw,d){
    maj <- sum(rw[1:d]) / d
    return(if(maj > 0.5) 1 else 0)
}
copymaj

x <- matrix(c(1,1,1,0,0,1,0,1,1,1,0,1,1,1,1,1,0,0,1,0), nrow=4)
x
apply(x,1,copymaj,3)
apply(x,1,copymaj,2)

## INTERESTING FACT: contrary to common opinion, using apply() will generally not speed up your code. 
# The benefits are that it makes for very compact code, which may be easier to read and modify.
# Also, as R moves closer to parallel processing, functions like apply() will become more and more important

# 3.3.2 Extended Example: Finding Outliers
# omitted, as usual. Useful to read through this section though.


#####
# 3.4 Adding and Deleting Matrix Rows and Columns 

# Technically, matrices are of fixed length and dimensions, so we cannot add or delete rows or columns. 
# However, matrices can be reassigned, which accomplishes almost the same thing. 

#3.4.1 Changing the size of a matrix
# First recall how we reassign vectors to change their size

x <- c(12 5 13 16 18)
x
x z- c(x,20) #append 20
x
x <- c(x[1:3], 20, x[4:6]) #insert 20
x
x <- x[-2:4] #delete elements 2 through 4
x

#Note: reassignment occurs even when you don't see it

#Analogous operations can be used to change the size of a matrix. For instance, rbind() and cbind() let you add rows or cols to a matrix:
one <- c(1,1,1,1)
one
z <- matrix(c(1,2,3,4,1,1,0,0,1,0,1,0), nrow=4)
z
cbind(one,z)
#could also do
z <- cbind(one,z)
#or, we could have relied on recycling here:
cbind(1,z)

# we can also use rbind and cbind as a quick way to create small matrices:
q <- cbind(c(1,2), c(3,4))
q

# be aware that rbind and cbind may be creating a new matrix on every call, which could become time-consuming
# If you are adding rows or cols one at a time within a loop and the matrix will eventually become large, 
# it's better to allocate a large matrix in the first place. It will be empty at first but then you fill in the values rather than 
# doing a memory re-allocation each time.

#you can delete rows or cols by reassignment too:
m <- matrix(1:6, nrow=3)
m
m <- m[c(1,3),]
m

# 3.4.2 Extended Example: Finding the closest pair of vertices in a graph
# Very interesting (and useful to me) example, but omitted from here as usual. Definitely worth reading through though!


#####
# 3.5 More on the Vector/Matrix Distinction 







