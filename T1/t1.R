The following code demonstrates three approaches to handling missing data (from worst to best) and introduces functional programming concepts in R.

#Create a 6×6 matrix with random values from 1-10 and -999 (representing missing data)
#Converts to dataframe with columns named a, b, c, d, e, f
#-999 is a common code for missing values in datasets
x = matrix(sample(c(1:10, -999), 36, rep = TRUE), nrow=6)
df <- data.frame(x)
names(df) <- letters[1:6]

Approach 1: Manual Replacement (WORST ❌)
df$a[df$a == -999] <- NA
df$b[df$b == -999] <- NA
df$c[df$c == -989] <- NA  # TYPO: should be -999
df$d[df$d == -999] <- NA
df$e[df$e == -999] <- NA
df$f[df$g == -999] <- NA  # ERROR: column 'g' doesn't exist!

Approach 2: Using a Function (BETTER ✓)
fix_missing <- function(x) {
  x[x == -999] <- NA
  x
}

df$a <- fix_missing(df$a)
df$b <- fix_missing(df$b)
df$c <- fix_missing(df$c)
df$d <- fix_missing(df$d)
df$e <- fix_missing(df$e)
df$f <- fix_missing(df$e)  # TYPO: uses df$e instead of df$f

Approach 3: Using lapply() (BEST ✅)
fix_missing <- function(x) {
  x[x == -99] <- NA  # Note: changed to -99 in this example
  x
}

df[] <- lapply(df, fix_missing)

Part 2: Functional Programming Building Blocks
1. Anonymous Functions - Anatomy
formals(function(x = 4) g(x) + h(x))      # Parameters: x = 4
body(function(x = 4) g(x) + h(x))         # Function body: g(x) + h(x)
environment(function(x = 4) g(x) + h(x))  # Environment: where function was created
#Every R function has three components:
#1. Formals - the arguments/parameters
#2. Body - the code inside the function
#3. Environment - where the function can find variables

2. Closures - Function Factories
power <- function(exponent) {
  function(x) {
    x ^ exponent
  }
}

square <- power(2)  # Creates a function: function(x) x^2
cube <- power(3)    # Creates a function: function(x) x^3

            Example:
            square(5)  # Returns 25 (5^2)
cube(5)    # Returns 125 (5^3)

3. List of Functions
funs2 <- list(
  sum = function(x, ...) sum(x, ..., na.rm = TRUE),
  mean = function(x, ...) mean(x, ..., na.rm = TRUE),
  median = function(x, ...) median(x, ..., na.rm = TRUE)
)

lapply(funs2, function(f) f(x))

       Breakdown:
       function(f) f(x)  # Anonymous function that takes a function 'f' and calls it on 'x'
```

**Result would be:**
```
$sum
[1] <sum of x>

$mean
[1] <mean of x>

$median
[1] <median of x>
