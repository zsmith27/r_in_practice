## ---- fig.height=2-------------------------------------------------------
suppressPackageStartupMessages(library(ggplot2))
data("iris")

ggplot(iris, aes(Sepal.Length, Sepal.Width, color = Species)) +
  geom_point()


## ---- echo=FALSE, fig.height=2-------------------------------------------
ggplot(iris, aes(Species, Sepal.Width, color = Species)) +
  geom_boxplot()

