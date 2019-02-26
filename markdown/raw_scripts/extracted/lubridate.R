## ------------------------------------------------------------------------
library(lubridate)
suppressPackageStartupMessages(
 library(dplyr) 
)

## ------------------------------------------------------------------------
taxa.df <- file.path("data",
          "zms_thesis-macro_2017-06-18.csv") %>% 
  read.csv(stringsAsFactors = FALSE)

## ------------------------------------------------------------------------
dates.df <- taxa.df %>% 
  select(station_id, date) %>% 
  distinct()

DT::datatable(dates.df, options = list(columnDefs = list(list(className = 'dt-center', targets = 0:2))))

## ------------------------------------------------------------------------
mdy.df <- dates.df %>% 
  mutate(date = mdy(date))

DT::datatable(mdy.df, options = list(columnDefs = list(list(className = 'dt-center', targets = 0:2))))

## ------------------------------------------------------------------------
sapply(dates.df, class)

## ------------------------------------------------------------------------
sapply(mdy.df, class)

## ------------------------------------------------------------------------
extract.df <- mdy.df %>% 
  mutate(year = year(date),
         month_int = month(date),
         month_abv = month(date, label = TRUE),
         month_full = month(date, label = TRUE, abbr = FALSE),
         week = week(date),
         day = day(date),
         wday_int = wday(date),
         wday_abv = wday(date, label = TRUE),
         wday_full = wday(date, label = TRUE, abbr = FALSE),
         mday = mday(date),
         qday = qday(date),
         yday = yday(date),
         hour = hour(date),
         minute = minute(date),
         second = second(date))

DT::datatable(extract.df, options = list(scrollX = TRUE))

## ------------------------------------------------------------------------
round.df <- mdy.df %>% 
  mutate(round_week = round_date(date, "week"),
         round_month = round_date(date, "month"),
         round_year = round_date(date, "year"),
         round_year5 = round_date(date, "5 years"),
         round_century = round_date(date, "100 years"),
         floor_month = floor_date(date, "month"),
         floor_year = floor_date(date, "year"),
         ceiling_month = ceiling_date(date, "month"),
         ceiling_year = ceiling_date(date, "year"))

DT::datatable(round.df, options = list(scrollX = TRUE,
                                       autoWidth = TRUE,
                                       columnDefs = list(list(width = '70px', targets = c(2)))))

