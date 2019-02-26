## ---- echo=FALSE---------------------------------------------------------
urls <- c("https://cran.r-project.org/bin/windows/base/",
          "https://www.rstudio.com/products/rstudio/download/#download",
          "https://git-scm.com/downloads",
          "https://github.com")
link.df <- data.frame(
  Software = c("R", "RStudio", "Git", "GitHub"),
  Link = paste0("[", urls, "](", urls, ")")
)

knitr::kable(link.df)

## ---- eval=FALSE---------------------------------------------------------
## # installing/loading the package:
## if(!require(installr)) {
## install.packages("installr");
## require(installr)
## } #load / install+load installr
## 
## # using the package:
## updateR()

## ---- eval=FALSE---------------------------------------------------------
## package.vec <- c("tidyverse", "lubridate",
##                  "knitr", "rmarkdown", "markdown", "caTools", "bitops",
##                  "DT", "leaflet", "shiny", "jasonlite",
##                  "data.table", "rprojroot", "viridis")
## 
## install.packages(package.vec)

