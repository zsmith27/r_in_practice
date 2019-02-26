## ---- eval=FALSE---------------------------------------------------------
## ---
## title: "Untitled"
## author: "Zachary M. Smith"
## date: "September 23, 2018"
## output: html_document
## ---

## ---- eval=FALSE---------------------------------------------------------
## sections.path <- c("markdown/sections")
## r.files.vec <- list.files(sections.path)
## r.file.vec <- r.files.vec[grepl(".Rmd", r.files.vec)]

## ---- eval=FALSE---------------------------------------------------------
## extracted.path <- c("markdown/raw_script/extracted")
## purrr::map(r.files.vec, function(file.i) {
##   file.name <- gsub(".Rmd", "", ".R")
##   extracted.file <- paste0(file.name, ".R")
##   knitr::purl(
##     file.path(sections.path, file.i),
##     file.path(extracted.path, extracted.file)
##     )
## })

## ---- eval=FALSE---------------------------------------------------------
## source.vec <- c(
##   "import_data.R",
##   "clean_data.R",
##   "visualize_data.R"
## )
## 
## purrr::map(source.vec, function(source.i) {
##   source(file.path(extracted.path, source.i))
## })

