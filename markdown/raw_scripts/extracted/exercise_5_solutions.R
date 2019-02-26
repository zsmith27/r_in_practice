## ------------------------------------------------------------------------
iris.df <- iris

## ------------------------------------------------------------------------
sapply(month.name, function(i) {
  paste(i, "2019")
})

## ------------------------------------------------------------------------
sapply(unique(iris.df$Species), function(species.i) {
  sub.df <- iris.df[iris.df$Species == species.i, ]
  mean(sub.df$Petal.Width)
})

