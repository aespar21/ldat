% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/generate.R
\name{generate}
\alias{generate}
\title{Generate an lvec with (random) values}
\usage{
generate(n, fun, ..., chunk_size = 5e+06)
}
\arguments{
\item{n}{number of elements in result vector}

\item{fun}{function that generates values. Should accept a number of 
elements to generate as its first argument.}

\item{...}{additional arguments are passed on to \code{fun}.}

\item{chunk_size}{the size of the chunks of values with which to fill the
resulting \code{\link{lvec}}. When not given it uses the value of the 
option 'chunk_size' (see \code{\link{options}}) otherwise the default 
value.}
}
\value{
Returns an \code{\link{lvec}} with length \code{n}. The type is determined 
by the type of values returned by \code{fun}.
}
\description{
Generate an lvec with (random) values
}
\examples{
# generate an lvec with random normally distributed values with sd of 10
x <- generate(2E6, rnorm, sd = 10)
# generate lvec with random letters; use sample; expects n as its second
# argument, but we work around that by explicitly naming first argument x
y <- generate(2E6, sample, x = letters, replace = TRUE)

}

