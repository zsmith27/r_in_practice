## ------------------------------------------------------------------------
subtract <- function(x, y) {
  x - y
}

## ------------------------------------------------------------------------
subtract(x = 10, y = 5)

## ------------------------------------------------------------------------
subtract(10, 5)

## ------------------------------------------------------------------------
subtract(5, 10)

## ------------------------------------------------------------------------
subtract(c(1, 2, 3), c(3, 2, 1))

## ------------------------------------------------------------------------
subtract <- function(x, y) {
  if (length(x) != 1 | length(y) != 1) stop("x and y must length 1")
  x - y
}

## ---- error=TRUE---------------------------------------------------------
subtract(c(1, 2, 3), c(3, 2, 1))

## ------------------------------------------------------------------------
subtract(10, 5)

