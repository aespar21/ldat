

ldat: out of memory vectors in R
===========================================================

This R package contains functions and methods for working with vectors and 
data sets that are too large to fit into memory. The data is kept (partially)
on disk using memory mapping. 

The package extends the basic functionality provided by the 
[`lvec`](https://github.com/djvanderlaan/lvec) package, which implements 
integer, logical, and numeric memory mapped vectors. It 
implements additional functionality to make working with these objects easier. It
implements various base R methods, such a `mean ` and `table`, for `lvec`
objects. Furthermore, it implements data.frame-like objects (`ldat` objects) 
that can be used to work with data sets too large to fit into memory. 


## Implementations for existing base R methods ##

The following functions and methods are implemented for `lvec` objects:

- Indexing: `[]` and `[]<-`. Indexing returns an lvec object.
- Mathematical operators: `"+"`, `"-"`, `"*"`, `"/"`, `"^"`, `"%%"`, `"%/%"` 
  `"&"`, `"|"`, `"!"`, `"=="`, `"!="`, `"<"`, `"<="`, `">="`, `">"`. These
  return an lvec object.
- Summarising functions: `all`, `any`, `prod`, `sum`, `mean`, `max`, `min`, 
  `range`, `quantile`, `median`. These all return an R-vector.
- Math functions: `abs`, `sign`, `sqrt`, `floor`, `ceiling`, `trunc`,
  `round`, `signif` `exp`, `log`, `expm1`, `log1p`, `cos`, `sin`, `tan`,
  `cospi`, `sinpi`, `tanpi`, `acos`, `asin`, `atan`, `cosh`, `sinh`, `tanh`,
  `acosh`, `asinh`, `atanh`, `lgamma`, `gamma`, `digamma`, `trigamma`, `cumsum`, 
  `cumprod`, `cummax`, `cummin`. These all return an lvec.
- `table`: cross tables of lvec objects.
- `duplicated`: check for duplicated values in an lvec object.
- `unique`: select unique values from an lvec object.
- `which`: return the indices of true elements.
- `match`: lookup elements in a other vector
- `is.na`: logical vector with missing values.

These methods make working with `lvec` objects almost the same as working with
regular R vectors. Some examples:

Create an vector with random numbers (in this case the vector is first 
generated in memory, for long vector the `generate` function can be used) and 
set some values to missing:

```r
x <- as_lvec(rnorm(1E6))
x[c(1,5)] <- NA
```

Calculate the mean

```r
mean(x, na.rm = TRUE)
```

```
## [1] 0.001296758
```

Truncate values to the range -1--1:

```r
x[abs(x) > 1 & !is.na(x)] <- 1
```

Sort `x`:

```r
sort(x)
```

```
## numeric lvec of length 1,000,000:
##        [1] -0.9999980 -0.9999964 -0.9999953 -0.9999950 -0.9999930
##        [6] -0.9999921 -0.9999726 -0.9999696 -0.9999667 -0.9999606
##       [11] -0.9999593 -0.9999538 -0.9999500 -0.9999480 -0.9999409
##       [16] -0.9999405 -0.9999393 -0.9999376 -0.9999354 -0.9999347 
##       ... 
##   [999981]  1.0000000  1.0000000  1.0000000  1.0000000  1.0000000
##   [999986]  1.0000000  1.0000000  1.0000000  1.0000000  1.0000000
##   [999991]  1.0000000  1.0000000  1.0000000  1.0000000  1.0000000
##   [999996]  1.0000000  1.0000000  1.0000000         NA         NA
```

Attributes of vectors are preserved, which means that one can work with 
`factor` and `Date` objects:

```r
y <- as_lvec(factor(sample(letters, 1000, replace = TRUE)))
print(y)
```

```
## integer lvec of length 1,000:
##     [1] x x v c z g d x a i y u o d b f n g x s 
##    ... 
##   [981] x p k w r j r a r i c y r q o t j y e n
```

```r
table(y)
```

```
## Var1
##  a  b  c  d  e  f  g  h  i  j  k  l  m  n  o  p  q  r  s  t  u  v  w  x  y 
## 53 29 28 38 30 44 42 41 37 35 45 36 40 36 33 42 33 43 52 30 39 38 39 45 45 
##  z 
## 27
```



## Data.frame-like objects ##

`ldat` objects can be used to work with data sets. A `ldat` objects mimics as
close as possible the functionality of a `data.frame`. Under the hood it is a
list with `lvec` objects.

Create a new ldat

```r
dta <- ldat(a = 1:10, b = rnorm(10))
print(dta)
```

```
## ldat with 10 rows and 2 columns:
##     a          b
## 1   1  0.1654209
## 2   2 -0.2296862
## 3   3  2.3058329
## 4   4  1.5841429
## 5   5 -1.2025777
## 6   6 -0.2723950
## 7   7 -0.7798062
## 8   8  1.0456655
## 9   9 -1.7315145
## 10 10 -0.7361830
```

Create one from an existing dataset

```r
dta <- as_ldat(iris)
```

An `ldat` object can be indexed as regular data.frame (one difference is that
rows and or columns will not be dropped, e.g. `drop = FALSE`). It will return a new
`ldat` object.

```r
dta[1:3, ]
```

```
## ldat with 3 rows and 5 columns:
##   Sepal.Length Sepal.Width Petal.Length Petal.Width Species
## 1          5.1         3.5          1.4         0.2  setosa
## 2          4.9         3.0          1.4         0.2  setosa
## 3          4.7         3.2          1.3         0.2  setosa
```

```r
dta[dta$Sepal.Width > 4, ]
```

```
## ldat with 3 rows and 5 columns:
##   Sepal.Length Sepal.Width Petal.Length Petal.Width Species
## 1          5.7         4.4          1.5         0.4  setosa
## 2          5.2         4.1          1.5         0.1  setosa
## 3          5.5         4.2          1.4         0.2  setosa
```

```r
dta[1:5, 1:2]
```

```
## ldat with 5 rows and 2 columns:
##   Sepal.Length Sepal.Width
## 1          5.1         3.5
## 2          4.9         3.0
## 3          4.7         3.2
## 4          4.6         3.1
## 5          5.0         3.6
```

```r
dta[1:5, "Sepal.Width"]
```

```
## ldat with 5 rows and 1 columns:
##   Sepal.Width
## 1         3.5
## 2         3.0
## 3         3.2
## 4         3.1
## 5         3.6
```

Converting to a data.frame:

```r
as.data.frame(dta[1:4, ])
```

```
##   Sepal.Length Sepal.Width Petal.Length Petal.Width Species
## 1          5.1         3.5          1.4         0.2  setosa
## 2          4.9         3.0          1.4         0.2  setosa
## 3          4.7         3.2          1.3         0.2  setosa
## 4          4.6         3.1          1.5         0.2  setosa
```



## Chunkwise processing of `lvec` and `ldat` objects ##

Although some basic functionality has been implemented for `ldat` and `lvec`
objects (see above), in practice, one will of course want to do stuff that isn't
implemented. One solution is to copy the data to a regular R-object, perform the
computation in R and if necessary copy the result back to an `lvec` or `ldat` 
object. This could for example be an option when a complete dataset doesn't fit
into memory, but the few columns needed for a computation do. An `lvec` object
can be converted to an R-object using `as_rvec` and an `ldat` object using 
`as.data.frame`. 


```r
dta <- as_ldat(iris)
cor(as_rvec(dta$Sepal.Length), as_rvec(dta$Sepal.Width))
```

```
## [1] -0.1175698
```

However, in practice, the data doesn't always fit into memory, or one can not
assume it does. In that case chunkwise, or blockwis, processing can often be
used. Many of the functions mentioned above have been implemented using 
chunkwise processing. With chunkwise processing one reads a chunk of data into
memory, performs some computation on that chunk before copying the next chunk 
into memory. The `ldat` and `lvec` packages contain some helper functions for
that. 

One use case is calculating a new value for each element in a vector. The code 
below demontrates how this can be done using the helper functions `chunk` and
`slice_range`. In this case the month name is calculated for each element in 
a `Date` vector.


```r
x <- as_lvec(seq.Date(as.Date("1900-01-01"), as.Date("2050-12-31"), 
    by = "days"))

m <- lvec(length(x), "character", strlen = 3)
chunks <- chunk(x)
for (c in chunks) {
  d <- slice_range(x, range = c, as_r = TRUE)
  m[range = c] = months(d, abbreviate = TRUE)
}
```

Since this is a common operation, `ldat` also contains a special helper function
for this use case, `elementwise`, which applies a function to each element, in 
this case `months`

```r
m <- elementwise(x, months, abbreviate = TRUE)
```

Another common pattern (of which the pattern above is a special case) is to 
perform a calculation for each chunk using the result from the previous chunk, 
and finally calculate the end result. 


```r
# Generate an lvec with random normal values
y <- generate(2E6, rnorm)

# Calculate men of x 
state <- c(n = 0, sum = 0)
chunks <- chunk(y)
for (c in chunks) {
  d <- slice_range(y, range = c, as_r = TRUE)
  state[1] <- state[1] + length(d)
  state[2] <- state[2] + sum(d)
}
state[2]/state[1]
```

```
##           sum 
## -1.889606e-06
```

For this pattern there is also the helper function `chunkwise`. This function 
accepts an `lvec` or `ldat` object and three functions: an init function which
initialises the state, an update function which updates the state using a new
chunk of data, and a final function calculating the end result from the state. 
The calculation of the mean can then be written as:


```r
chunkwise(y, init = function(x) c(0,0),
  update = function(state, x) c(state[1] + length(x), state[2] + sum(x)),
  final = function(state) state[2]/state[1])
```

```
## [1] -1.889606e-06
```

When, looking at `ldat::mean.lvec`, you'll see that, except for some stuff with
`na.rm`, this is also how that function is written. 

Another function that is usefull when chunkswise processing `lvec` or `ldat` 
objects, is the `append` function, which appends one object to another (
as `c` for vectors, and `rbind` for data.frames). For `ldat` and `lvec` objects
this method has a `clone` argument. When set to `FALSE` (for safety the default 
is `TRUE`), the second vector is appended to the first, modifying the first
argument. The advantage of that is that the first vector does not need to be
copied. Append can be used to create a result for which the final size is not
known at the beginning (if the size is known it is more efficient the initialise
the result to the correct size directly at the beginning). 

In the code below `x` is copied and therefore not modified:

```r
x <- as_lvec(1:10)
z <- append(x, 100:1009)
x
```

```
## integer lvec of length 10:
##  [1]  1  2  3  4  5  6  7  8  9 10
```

In the code below the new data is appended to `x` and `x` is modified. `x` and
`z   now point to the same vector:

```r
x <- as_lvec(1:10)
z <- append(x, 100:1009, clone = FALSE)
x
```

```
## integer lvec of length 920:
##    [1]    1    2    3    4    5    6    7    8    9   10  100  101  102
##   [14]  103  104  105  106  107  108  109 
##   ... 
##  [901]  990  991  992  993  994  995  996  997  998  999 1000 1001 1002
##  [914] 1003 1004 1005 1006 1007 1008 1009
```



## Other functions for working with lvec objects ##


- `generate`: generate an lvec object filled with (random) values. 
- `partial_sort`: ensure that an lvec is sorted in such a way, that values
  before a given element number are smaller than that element and values after
  that element are larger. 
- `partial_order`: as above, but returns the order, e.g. the indexing vector 
  that would result in a partiallr sorted vector. 



