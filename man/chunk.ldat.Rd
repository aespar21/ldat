% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/chunk_ldat.R
\name{chunk.ldat}
\alias{chunk.ldat}
\title{Generate a number of index ranges from an ldat object}
\usage{
\method{chunk}{ldat}(x, chunk_size = 5e+06, ...)
}
\arguments{
\item{x}{an object of type \code{\link{ldat}} for which the index ranges 
should be calculated.}

\item{chunk_size}{a numeric vector of length 1 giving the maximum length of
the chunks. When not given it uses the value of the option 'chunk_size' 
(see \code{\link{options}}) otherwise the default value.}

\item{...}{ignored; used to pass additional arguments to other methods.}
}
\description{
The ranges have a maximum length.
}
\details{
The default chunk size can be changes by setting the option 'chunk_size', 
(`options(chunk_size = <new default chunk size>)`).
}

