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
y[1] <- 5
y[2] <- 12 # does work

y <- c(5,12) # also works

#this is also perfectly valid:
x <- c(1,5)
x
x <- "abc"


#####
# 2.3: Recycling

#here is an example of recycling:
c(1,2,4) + c(6,0,9,20,22)
#gives the same result as:
c(1,2,4,1,2) + c(6,0,9,20,22)

#a more subtle example:
x <- cbind(c(1,2,3), c(4,5,6))
x
x + c(1,2) #remember, matrices are actually long vectors!


#####
# 2.4: Common Vector Operations

#2.4.1 Vector Arithmetic and Logical Operations
2+3
"+"(2,3) #both give the same result

x <- c(1,2,4)
x + c(5,0,-1) #addition of vectors is element-wise

x * c(5,0,-1) #so is multiplication...

#this applies to other numeric operators as well:
x <- c(1,2,4)
x / c(5,4,-1)
x %% c(5,4,-1)

#2.4.2 Vector Indexing
# (One of the most common and frequently used operations in R)

y <- c(1.2, 3.9, 0.4, 0.12)
y[c(1,3)] # extract elements 1 and 3 of y
y[2:3]
v <- 3:4
y[v]

x <- c(4,2,17,5)
y <- v[c(1,1,3)]

# Negative subscripts are used to exclude given elements:
z <- c(5, 12, 13)
z[-1] # exclude element 1
z[-1:-2] # exclude elements 1 through 2

#the length() function can be useful here
z <- c(5,12,13)
z[1:length(z)-1]
# equivalently:
z[-length(z)]

#2.4.2 Generating Useful Vectors with the : Operator
5:8
5:1
# we've used this before: for (i in 1:length(x)){}

# Beware of operator precedence issues:
i <- 2
1:i-1 #this means (1:i) - 1
1:(i-1)

## NOTE: learn about operator precedence by typing ?Syntax
?Syntax


#2.4.4 Generating Vector Sequences with seq()

#seq() is a generalization of :
seq(from=12,to=30,by=3)
seq(1.1,2,length=10)

#one handy use for seq() is to deal with the empty vector problem we encountered in section 2.12: for (i in 1:length(x)) 
#can be replaced with for (i in seq(x)):

x <- c(5,12,13)
x
seq(x)

x <- NULL
seq(x)


#2.4.5: Repeating Vector Constants with rep()
# the call form is: rep(x,times)

x <- rep(8,4)
x
rep(c(5,12,13),3)
rep(1:3, 2)

#also a named argument, "each"
rep(c(5, 12, 13), each=2)


#####
# 2.5 Using all() and any()

# any() and all() are handy shortcuts which report whether any or all of their arguments are TRUE
x <- 1:10
any(x > 8)
any(x > 88)
all(x > 8)
all(x > 0)

# 2.5.1 Extended Example: Finding Runs of Consecutive Ones
# start with a function to do this:

findruns <- function(x,k) {
    n <- length(x)
    runs <- NULL
    for (i in 1:(n-k+1)){
        if(all(x[i:(i+k-1)]==1)){
            runs <- c(runs,i)
        }
        return(runs)
    }
}

#let's test it:
y <- c(1,0,0,1,1,1,0,1,1)
findruns(y,3)
findruns(y,2)
findruns(y,6)

#although the code is correct, it may be slow since each call to runs<-c(runs,i) allocates a new vector
#an alternative is to preallocate the memory space like this:
findruns1 <- function(x,k) {
    n <- length(x)
    runs <- vector(length=n)
    count <- 0
    for (i in 1:(n-k+1)){
        if(all(x[i:(i+k-1)]==1)){
            count <- count + 1
            runs[count] <- i
        }
    }
    if (count > 0){
        runs <- runs [1:count]
    } else runs <- NULL
    return(runs)
}


# 2.5.2: Extended Example: Predicting Discrete-Valued Time Series



