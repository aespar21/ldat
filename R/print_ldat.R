


#' @export
print.ldat <- function(x, ...) {
   l <- nrow(x)
   cat("ldat with ", format(nrow(x), big.mark = ' '), " rows and ", 
     ncol(x), " columns:\n", sep = "")
   if (l < 20) {
     r <- as.data.frame(x)
     print(r)
   } else {
     # Selecr first set of rows
     r1 <- lapply(x, function(d) as_rvec(lget(d, range = c(1, 10))))
     r1  <- as.data.frame(r1, stringsAsFactors = FALSE)
     rownames(r1) <- seq(1, 10)
     # Select last set of rows
     range <- l - c(10, 1) + 1
     r2 <- lapply(x, function(d) as_rvec(lget(d, range = range)))
     r2  <- as.data.frame(r2, stringsAsFactors = FALSE)
     rownames(r2) <- seq(range[1], range[2])
     # Combine first and last set, insert row with :
     r <- format(rbind(r1, NA, r2))
     r[11, ] <- ":"
     rownames(r)[11] <- ":"
     # and print
     print(r)
   }
   invisible(x)
}
