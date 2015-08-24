#####
# CHAPTER 5: DATA FRAMES
# The Art of R Programming, by Norman Matloff
#
# Focus of this chapter: Examples of data frames and their various uses in R. 
#####

#####
# 5.1: Creating Data Frames

#To begin, let's take another look at our simple data frame example from Section 1.4.5:
kids <- c("Jack","Jill")
ages <- c(12, 10)
d <- data.frame(kids, ages, stringsAsFactors=FALSE)  #produce a data frame from our two vectors: kids and ages
d
#stringsAsFactors means that if we create a data frame from a character vector (in this case kids) then R will convert that to a factor by default.
#here we set the variable to false since we want to work with vectors rather than factors.
#Factors will be covered in Chapter 6.

#5.1.1: Accessing Data Frames
#Now that we have a data frame, let's explore a bit.

#Since d is a list we can access it as such via component index values or component names:
d[[1]]
d$kids
#but we can treat it in a matrix-like fashion as well:
d[,1]
#this matrix-like quality is also seen when we take d apart using str():
str(d)

#5.1.2 Extended Example: Regression Analysis of Exam Grades Continued
#This is just the first 6 rows of a dataset. I need them to use the examples in following sections. 
examsquiz <- as.data.frame(matrix(c(2.0,3.3,4.0,2.3,2.3,3.3,3.3,2.0,4.0,0.0,1.0,3.7,4.0,3.7,4.0,3.3,3.3,4.0), nrow=6))
colnames(examsquiz) <- c("Exam.1" ,"Exam.2", "Quiz")
examsquiz

#####
# 5.2: Other Matrix-Like Operations

#5.2.1 Extracting Subdata Frames
#Use the examsquiz data for some examples:

examsquiz[2:5,]
examsquiz[2:5,2]
class(examsquiz[2:5,2])
examsquiz[2:5,2, drop=FALSE]
class(examsquiz[2:5,2, drop=FALSE])

#We can also do filtering






