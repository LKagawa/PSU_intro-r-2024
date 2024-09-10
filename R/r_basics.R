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


# data structures ----
# vectors have a single dimension, like a column or row of data

# data frames - the key structure for data science, multi-dimensional
#   collections of vectors


# Special type: factors, and putting it all together ----
# factors are categorical variables with a fixed set of
#   potential values


