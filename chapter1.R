# File for going through examples in CH1 of the art of R programming

rnorm(10)

setwd('C:\\Users\\Jane\\Documents\\Personal\\ArtofR')
getwd()

pdf("xh.pdf") #set graphical output file
hist(rnorm(100)) #generate 100 N(0,1) variants and plot their histogram
dev.off() #close the graphical output file

#####
# Section 1.2: A First R Session
x <- c(1,2,4)
q <- c(x,x,8)
x[3]
x[2:3]
mean(x)
sd(x)
y <- mean(x)
y
data()
mean(Nile)
sd(Nile)
hist(Nile)


#####
# Section 1.3: Introduction to Functions

# counts the number of odd integers in x
oddcount <- function(x) {
    k <- 0 # assign 0 to k
    for (n in x) {
        if (n %% 2 == 1) k <- k+1  # %% is the modulo operator
    }
    return(k)  #technically don't need to say return, k is fine 
}

oddcount(c(1,3,5))
oddcount(c(1,2,3,7,9))

38 %% 7

## 1.3.1: Variable Scope
z <- c(2,6,7)
oddcount(z)

f <- function(x) return (x+y)
y <-3   # a global variable
f(5)

## 1.3.2: Default Arguments
# g <- function(x, y=2,z=TRUE) { ... }

#####
# Section 1.4: Preview of Some Important R Data Structures

# 1.4.2: Character Strings
x <- c(5, 12, 13)
x
length(x)
mode(x)

y <- "abc"
y
length(y)
mode(y)

z <- c("abc", "29 88")
length(z)
mode(z)

u <- paste("abc", "de", "f")  #concatenate the strings
u

v <- strsplit(u, " ")
v

#1.4.3 Matrices
m <- rbind(c(1,4), c(2,2))
m
m %*% c(1,1)

m[1,2]
m[1,]
m[,2]

#1.4.4 Lists
x <- list(u=2, v="abc")
x
x$u

hn <- hist(Nile)
print(hn)
hn
str(hn)

#1.4.5 Data Frames
d <- data.frame(list(kids=c('Jack', 'Jill'), ages=c(12,10)))
d
d$ages

#####
# Section 1.5: Extended Example: Regression Analysis of Exam Grades

# Don't seem to have the data here... That's annoying. 
# I guess I'll type it out anyway, but it won't work without the data.





