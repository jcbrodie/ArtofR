#####
# CHAPTER 2: VECTORS
# The Art of R Programming, by Norman Matloff
#
# Focus of this chapter: Recycling, Filtering, Vectorization

#####
# 2.1: Scalars, Vectors, Arrays, and Matrices

# 2.1.1 Adding and deleting vector elements
x <- c(88, 5, 12, 13)
x <- c(x[1:3], 16, x[4]) #insert 168 before the 13
x

# 2.1.2 Obtaining the length of a vector
x <- c(1,2,4)
length(x)

#one way to write a function to determine the index of the first 1 value in the function's vector argument 
# (we are assuming that there is indeed such a value)
first1 <- function(x) {
    for (i in 1:length(x)){
        if (x[i] == 1) break   #break out of loop
    }
    return(i)
}

#Note that in the above, for (n in x) wouldn't work, because it doesn't let us retrieve the index of the desired element
#Also note, be careful that length(x) is not 0:
x <- c()
x
length(x)
1:length(x)

# A safe alternative would be to use seq() (discussed in section 2.4.4)

# 2.1.3 Matrices and arrays as vectors
m <- rbind(c(1,2), c(3,4))
m
m+10:13


#####
# 2.2: Declarations

# You do not need to declare variables in R
z <- 3

#be careful with vectors though:
y[1] <- 5 #does not work
y[2] <- 12

y <- vector(length=2)