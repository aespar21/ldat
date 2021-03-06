% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/lget_ldat.R
\name{lget.ldat}
\alias{lget.ldat}
\title{Read elements from an ldat object}
\usage{
\method{lget}{ldat}(x, ...)
}
\arguments{
\item{x}{the \code{\link{ldat}} to read from}

\item{...}{passed on to \code{\link{lget.lvec}}.}
}
\value{
Returns an \code{\link{ldat}} with the selected elements. In order to convert
the selection to an R-vector \code{\link{as_rvec}} can e used.
}
\description{
Read elements from an ldat object
}
\details{
Indexing using \code{index} should follow the same rules as indexing a regular
data.frame using a logical or numeric index. The range given by \code{range} 
includes both end elements. So, a range of \code{c(1,3)} selects the first 
three elements.
}

