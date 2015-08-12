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

