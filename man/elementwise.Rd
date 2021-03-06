% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/elementwise.R
\name{elementwise}
\alias{elementwise}
\title{Apply a function to each element of an lvec}
\usage{
elementwise(x, fun, ...)
}
\arguments{
\item{x}{an object of type \code{\link{lvec}}.}

\item{fun}{the function to apply to the \code{lvec}. This function receives
chunks of the lvec (which are regular R-vector) and should return a (R) 
vector of the same length as its input.}

\item{...}{passed on to \code{fun}.}
}
\value{
Returns a \code{link{lvec}} of the same length as the input. The type is 
determined by the output of \code{fun}.
}
\description{
Apply a function to each element of an lvec
}
\examples{
# Calculate square root of lvec
x <- as_lvec(1:10)
y <- elementwise(x, sqrt)
# of course, this is already implemented
sqrt(x)

}

