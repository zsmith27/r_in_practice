## ------------------------------------------------------------------------
is.numeric(c(1, 2, 3.5, 6.7))
is.numeric(c(1, 2, 3, 6))
is.numeric(1:5)
is.numeric(c(TRUE, FALSE, TRUE))
is.numeric(c("a", 2, 3, 6))
is.numeric(c("a", "b", "c", "d"))

## ------------------------------------------------------------------------
is.integer(c(1, 2, 3.5, 6.7))
is.integer(c(1, 2, 3, 6))
is.integer(1:5)
is.integer(c(TRUE, FALSE, TRUE))
is.integer(c("a", 2, 3, 6))
is.integer(c("a", "b", "c", "d"))

## ------------------------------------------------------------------------
is.logical(c(1, 2, 3.5, 6.7))
is.logical(c(1, 2, 3, 6))
is.logical(1:5)
is.logical(c(TRUE, FALSE, TRUE))
is.logical(c("a", 2, 3, 6))
is.logical(c("a", "b", "c", "d"))

## ------------------------------------------------------------------------
is.character(c(1, 2, 3.5, 6.7))
is.character(c(1, 2, 3, 6))
is.character(1:5)
is.character(c(TRUE, FALSE, TRUE))
is.character(c("a", 2, 3, 6))
is.character(c("a", "b", "c", "d"))

## ------------------------------------------------------------------------
is.factor(c(1, 2, 3.5, 6.7))
is.factor(c(1, 2, 3, 6))
is.factor(1:5)
is.factor(c(TRUE, FALSE, TRUE))
is.factor(c("a", 2, 3, 6))
is.factor(c("a", "b", "c", "d"))

## ------------------------------------------------------------------------
sort(c("a", "b", "c", "d"))

## ------------------------------------------------------------------------
sort(factor(c("a", "b", "c", "d"),
            levels = c("d", "a", "c", "b")))

## ------------------------------------------------------------------------
as.numeric(sort(factor(
  c("a", "b", "c", "d"),
  levels = c("d", "a", "c", "b")
  )))

