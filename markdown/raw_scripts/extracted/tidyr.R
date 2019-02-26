## ------------------------------------------------------------------------
library(tidyr)
suppressPackageStartupMessages(
 library(dplyr) 
)

## ------------------------------------------------------------------------
taxa.df <- file.path("data",
          "zms_thesis-macro_2017-06-18.csv") %>% 
  read.csv(stringsAsFactors = FALSE)

## ------------------------------------------------------------------------
ord.df <- taxa.df %>% 
  select(unique_id, order, count) %>% 
  group_by(unique_id, order) %>% 
  summarize(count = sum(count)) %>% 
  ungroup()

DT::datatable(ord.df, options = list(columnDefs = list(list(className = 'dt-center', targets = 0:3))))

## ------------------------------------------------------------------------
wide.df <- ord.df %>% 
  spread(order, count)

DT::datatable(wide.df, options = list(scrollX = TRUE))

## ------------------------------------------------------------------------
wide.df <- ord.df %>% 
  spread(order, count, fill = 0)

DT::datatable(wide.df, options = list(scrollX = TRUE))

## ------------------------------------------------------------------------
long.df <- wide.df %>% 
  gather(order, count)

DT::datatable(long.df,
              options = list(columnDefs = list(list(className = 'dt-center', targets = 0:2))))

## ------------------------------------------------------------------------
long.df <- wide.df %>% 
  gather(order, count, -unique_id)

DT::datatable(long.df,
              options = list(columnDefs = list(list(className = 'dt-center', targets = 0:3))))

## ------------------------------------------------------------------------
sep.df <- long.df %>% 
  separate(unique_id, c("lake", "station_id", "replicate"), sep = "_")

DT::datatable(sep.df,
              options = list(columnDefs = list(list(className = 'dt-center', targets = 0:5))))

## ------------------------------------------------------------------------
sep.df <- long.df %>% 
  separate(unique_id,
           c("lake", "station_id", "replicate"),
           sep = "_",
           remove = FALSE)

DT::datatable(sep.df,
              options = list(columnDefs = list(list(className = 'dt-center', targets = 0:6))))

## ------------------------------------------------------------------------
unite.df <- sep.df %>% 
  unite("unique_id2",
        c("lake", "station_id", "replicate"),
        sep = "-")

DT::datatable(unite.df,
              options = list(columnDefs = list(list(className = 'dt-center', targets = 0:4))))

## ------------------------------------------------------------------------
unite.df <- sep.df %>% 
  unite("unique_id2",
        c("lake", "station_id", "replicate"),
        sep = "-",
        remove = FALSE)

DT::datatable(unite.df,
              options = list(columnDefs = list(list(className = 'dt-center', targets = 0:7))))

