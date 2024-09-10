#### R Basics ####
# "A foolish consistency is the hobgoblin of 
#   little minds"   -Ralph Waldo Emerson 

# Literals ----
"This is a string literal" # COMMENT: double quotes preferred in R; not required
42 # numbers are colored different from strings
T # is True; F is False
TRUE # is also True; False is False

# Operators ----
  # Arithmetic ----
  2 + 3 # spaces between operators encouraged for legibility
  2 - 3
  2 * 3
  2 / 3
  2 ** 3 # exponential
  2 ^ 3 # also exponential

  # Comparison ----
  2 == 2 # tests for equality
  2 == (1 + 1)
  "Joe" == "joe" # is case-sensitive
  2 != 2 # tests for inequality
  2 < 3
  2 <= 3
  2 < 3 & 2 > 3 # both have to pass to return true
  2 < 3 | 2 > 3 # only one condition to be true; stops operation when true
  2 < 3 & ( 2 == 1 | 2 == 2) # parenthesize to group statements for ordering
  
    # Confusing bit ----
    TRUE == 1 # statement is true
    FALSE == 0 # statement is true
    isTRUE(TRUE) # function tests if the argument is literally true
    isTRUE(1) # is false see line #31
    ?isTRUE # queries the built-in help to explain the function

  # Element Type
    "joe" # string or character (character)
    typeof("joe") # states the element type
    42 # numeric type (double precision, floating point)
    typeof(42) # states element type (double)
    typeof(TRUE) # logical or Boolean (logical)
    42 == "42" # equality can cross types
    identical(42, "42") # type matters for identity
    
    
# variables ----
x <- "string example x" # assigning a variable
x # prints the variable "x"
typeof(x)
x <- 3 # can override the variable assignment
x ^ 2
my_var <- (x * 2) # no spaces in variable names
my_var # returns '6'
my_var = 6 # also assigns variables, but is not standard nor recommended in R
xx <- "Test"


# data structures ----
# vectors have a single dimension, like a column or row of data
a <- c(x, xx, my_var) # assigns items to vector where function c is collector
b <- c(1, 2, 3)
b + 1 # adds 1 to each numbers in the vector
c <- c(1, 4, 6)
c + 1 # adds 1 to each numbers in the vector
a + 1 # cannot add to non numeric types (character)
b < c # compares each corresponding element of the vectors (F, T, T)
any(b < 3) # tests if each element of the vector are true
all(b < 3) # tests if all elements of vector are true
3 %in% a # tests if an element exists in a vector
!3 %in% c # tests if an element does not exist in a vector
  3 %not in% c # not a valid statement will produce an error


# data frames - the key structure for data science, multi-dimensional
#   collections of vectors


# Special type: factors, and putting it all together ----
# factors are categorical variables with a fixed set of
#   potential values


