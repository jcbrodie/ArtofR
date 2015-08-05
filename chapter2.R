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

#a naive approach:
preda <- function(x,k){
    n <- length(x)
    k2 <- k/2
    #the vector pred will contain our predicted values
    pred <- vector(length=n-k)
    for (i in 1:(n-k)){
        if (sum(x[i:(i+(k-1))]) >= k2) pred[i] <- 1 else pred[i] <- 0
    }
    return(mean(abs(pred-x[(k+1):n])))
}

# above coding is straightforward, simple, and compact
#BUT, it is probably slow
# Let's rewrite it now to take advantage of previous computation
# In each iteration we will update the previous sum we found rather than computing the new sum from scratch

predb <- function(x,k) {
    n <- length(x)
    k2 <- k/2
    pred <- vector(length=n-k)
    sm <- sum(x[1:k])
    if (sm >= k2) pred[1] <- 1 else pred[1] <- 0
    if (n-k >= 2) {
        for (i in 2:(n-k)){
            sm <- sm + x[i+k-1] - x[i-1]
            if (sm >= k2) pred[i] <- 1 else pred[i] <- 0
        }
    }
    return(mean(abs(pred-x[(k+1):n])))
}

# the above implementation is good, but we could use cumsum to improve it further:
predc <- function(x,k) {
    n <- length(x)
    k2 <- k/2
    pred <- vector(length=n-k)
    csx <- c(o,cumsum(x))
    for (i in 1:(n-k)){
        if (csx[i+k] - csx[i] >= k2) pred[i] <- 1 else pred[i] <- 0
    }
    return(mean(abs(pred-x[(k+1):n])))
}

# the above approach using cumsum requires just one subtraction operation per iteration of the loop, compared to two in predb


#####
# 2.6 Vectorized Operations

# One of the most effective ways to achieve speed in R code is to use vectorized operations

# 2.6.1: Vector In, Vector Out
# first some examples of vectorized functions

u <- c(5,2,8)
v <- c(1,3,9)
u > v

# example of an R function using vectorized operations
w <- function(x) return x+1
w(u)

sqrt(1:9)

y <- c(1.2, 3.9, 0.4)
z <- round(y)

# even operators like + are really functions:
y <- c(12,5,13)
y+4

#the same thing explicitly:
'+'(y,4)  ## note too that recycling occurs here! 4 becomes (4,4,4).

#now let's consider vectorized functions that appear to have scalar arguments
f <- function(x,c) return ((x+c)^2)  #c is intended to be a scalar here
f(1:3, 0)
f(1:3, 1)

# BUT, there is nothing in f() that keeps us from using a vector, eg:
f(1:3, 1:3)

#to restrict c to scalars, add some kind of check, for example:
f <- function(x,c){
    if (length(c) !0 1) stop ("vector c not allowed")
    return((x+c)^2)
}


# 2.6.2: Vector In, Matrix Out

z12 <- function(z) return(c(z, z^2))
x <- 1:8
z12(x) #returns 16 numbers
#would be natural to represent these numbers as a matrix
#we can use the matrix function:
matrix(z12(x), ncol=2)

#we can streamline things using sapply (simplify apply)
#the call sapply(x,f) applies the function f() to each element of x and then converts the result to a matrix
#here is an example:
z12 <- function(z) return (c(z, z^2))
sapply(1:8, z12) ## note, sapply is discussed further in Ch4


#####
# 2.7 NA and NULL Values

# Missing data is represented in R as NA
# NULL represents that the value in question simply doesn't exist, rather than being existent but unknown

# 2.7.1 Using NA
# In many of R's functions we can instruct the function to skip over any missing values, or NAs
# for example:
x <- c(88, NA, 12, 168, 13)
x
mean(x)
mean(x, na.rm=TRUE)
x <- c(88, NULL, 12, 168, 13)
mean(x)

#So we have to specify if we want R to ignore the NA, but it will automatically ignore a NULL

#There are multiple NA values, one for each mode:
x <- c(5, NA, 12)
mode(x[1])
mode(x[2])

y <- c("abc", "def", NA)
mode(y[2])
mode(y[3])


#2.7.2 Using NULL
#One use of NULL is to build up vectors in loops, in which each iteration adds another element to the vector
#in this example we build up a vector of even numbers:
z <- NULL
for (i in 1:10) if (i %% 2 == 0) z <- c(z,i)
z

#of course that is quite an artificial example, and there are better ways to do this task. 
#here are two more ways to find even numbers in 1:10
seq(2,10,2)
2*1:5

#BUT, the point was to demonstrate the differences between NA and NULL
#If we were to use NA in the previous example, we would get an unwanted NA in the result:
z <- NA
for (i in 1:10) if (i %% 2 == 0) z <- c(z,i)
z


#NULL values are really counted as nonexistent, as you can see here:
u <- NULL
length(u)
v <- NA
length(v)

## NULL is a special R object with no mode! ##


#####
# 2.8 Filtering

#This is another feature that reflects the functional language nature of R
# Filtering allows us to extract a vector's elements that satisfy certain conditions
#Filtering is one of the most common opertations in R, as statistical analyses often focus on data that satisfies conditions of interest









