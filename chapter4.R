#####
# CHAPTER 4: LISTS
# The Art of R Programming, by Norman Matloff
#
# Focus of this chapter: Creating and working with lists. List indexing, functions like apply(), and taking lists apart, among other things.
#####

# 4.1: Creating Lists
#Technically, a list is a vector.
#Ordinary vectors are atomic vectors, while lists are recursive vectors. 

#For our first look at lists, let's consider an employee database.
#For each employee, we want to store the name, salary, and a Boolean indicating union membership.

j <- list(name='Joe', salary=55000, union=T)
#we could print out j either full or by component
j

#actually, the component names (called tags in the R liuterature) such as salary are optional.
#We could alternatively do this:
jalt <- list("Joe", 55000, T)
jalt

#However, it is clearer and less error-prone to use names

#Names of list components can be abbreviated to whatever extent is possible without causing ambiguity:
j$sal

#And since lists are vectors, they can also be created via vector()
z <- vector(mode="list")
z[["abc"]] <- 3
z


#####
# 4.2: General List Operations

##4.2.1 List Indexing
#You can access a list component in several different ways:
j$salary
j[["salary"]]
j[[2]]
#each of these is useful in different contexts, as we will see in subsequent examples

#we can also do the following:
j[1:2]
j2 <- j[2]
j2 #returns the result in the form of a list
class(j2)

#note that 
j[[1:2]] #will not work

#but as we said before
j2a <- j[[2]]
j2a #works since we are only accessing a single element
class(j2a)
str(j2)

##4.2.2 Adding and Deleting List Elements

z <- list(a="abc", b=12)
z
z$c <- "sailing"  #add a c component to the original list. can do this after the list has been created, in contrast with other data structures.
#check to see the result of adding c:
z

#adding components can also be done via vector indexing:
z[[4]] <- 28
z[5:7] <- c(FALSE, TRUE, TRUE)
z

#Can delete a list component by setting it to NULL:
z$b <- NULL
z
#note that after deleting z$b, the indices of the elements after it move up by 1!

#You can also concatenate lists:
c(list("Joe", 55000, T), list(5))

##4.2.3 Getting the Size of a List
#Since a list is a vector, can do this using length():
length(j)

#4.2.4 Extended Example: Text Concordance
#Web search and other tupes of textual data mining are of great interest today, which is what this example is of. 
#Again, I'll omit it here since we don't have the files they used. 


#####
# 4.3: Accessing List Components and Values
#if the list components have tags, you can obtain them via names():
names(j)

#to obtain the values, use unlist():
ulj <- unlist(j)
ulj
class(ulj)
#the return value of unlist() is a vector, in this case a vector of character strings. note that the element names come from the components
#in the original list

#on the other hand, if we were to start with numbers, we would get numbers:
z <- list(a=5, b=12, c=13)
y <- unlist(z)
class(y)
y

#so the output of unlist() in this case was a numeric vector. what about if we have mixed types:

w <- list(a=5, b="xyz")
wu <- unlist(w)
class(wu)
wu
#here, R chooses the least common denominator: character strings

#if we want to remove the names in wu, we can:
names(wu) <- NULL
wu

#we can also remove the elements' names directly with unname:
wun <- unname(wu)
wun
#this also has the advantage of not destroying the names in wu, in case they are needed later.


#####
# 4.4: Applying Functions to Lists







