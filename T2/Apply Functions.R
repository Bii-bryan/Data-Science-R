This code demonstrates R's apply family functions (apply, lapply, sapply) for efficient data manipulation.

1. apply() - Apply Functions to Matrix Rows/Columns
set.seed(1)
df <- matrix(rnorm(20), nrow = 5, ncol = 4)
apply(df, 2, sum)
#Creates a 5×4 matrix with random normal values
#apply(df, 2, sum): Applies sum() function to dimension 2 (columns)
#2 = columns, 1 = rows
#Returns sum of each column

2. lapply() - Apply Functions to Lists
Creating List of Matrices
A <- matrix(rnorm(25), nrow = 5, ncol = 5)
B <- matrix(runif(25), nrow = 5, ncol = 5)
C <- matrix(rnorm(25, mean = 80, sd = 20), nrow = 5, ncol = 5)
My_List <- list(A, B, C)
#Creates three 5×5 matrices and stores them in a list.
#Extracting Elements with lapply()
`[`(A, 1,)  # Demonstrates bracket operator as a function (extracts row 1)
lapply(My_List, "[", , 2)  # Extract column 2 from each matrix
lapply(My_List, "[", 1,)   # Extract row 1 from each matrix
K = lapply(My_List, "[", 1, 1)  # Extract element [1,1] from each matrix

3. Use Case 1: Fixing Missing Values
x = matrix(sample(c(1:10,-999), 36, rep = TRUE), nrow = 6)
df <- data.frame(x)
names(df) <- letters[1:6]

fix_missing <- function(x) {
  x[x == -999] <- NA
  x
}
df[1:6] <- lapply(df[1:6], fix_missing)
#Applies fix_missing() to columns 1-6, replacing -999 with NA efficiently.

4. Use Case 2: Computing Summary Statistics
Basic Summary Function
df <- data.frame(matrix(rnorm(20), nrow = 5, ncol = 4))

summary <- function(x) {
  c(mean = mean(x), 
    median = median(x), 
    sd = sd(x), 
    mad = mad(x), 
    IQR = IQR(x))
}

xyz = lapply(df, summary)
xyz$X1  # Access summary for column X1
#lapply() returns a list where each element contains summary stats for one column
#Access results with $ operator
Handling Missing Values
summary <- function(x) {
  c(
    mean(x, na.rm = TRUE),
    median(x, na.rm = TRUE),
    sd(x, na.rm = TRUE),
    mad(x, na.rm = TRUE),
    IQR(x, na.rm = TRUE)
  )
}

lapply(df, summary)   # Returns list
sapply(df, summary)   # Returns matrix (simplified)
#Added na.rm = TRUE to handle NA values
#sapply() simplifies output to a matrix instead of a list (easier to read)

5. Advanced: Functional Approach (Optional)
summary_2 <- function(x) {
  funs <- c(mean, median, sd, mad, IQR)
  lapply(funs, function(f) f(x, na.rm = TRUE))
}

lapply(mtcars, summary_2)   # Returns nested list
sapply(mtcars, summary_2)   # Returns matrix
