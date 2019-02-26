## ------------------------------------------------------------------------
library(ggplot2)

suppressPackageStartupMessages(
 library(dplyr) 
)

library(tidyr)

## ------------------------------------------------------------------------
taxa.df <- file.path("data",
          "zms_thesis-macro_2017-06-18.csv") %>% 
  read.csv(stringsAsFactors = FALSE)

## ------------------------------------------------------------------------
ord.df <- taxa.df %>% 
  select(unique_id, station_id, lake, order, count) %>% 
  group_by(unique_id, station_id, lake, order) %>% 
  summarize(count = sum(count)) %>% 
  ungroup() %>% 
  group_by(station_id, lake, order) %>% 
  summarize(count = mean(count)) %>% 
  ungroup()

DT::datatable(ord.df, options = list(columnDefs = list(list(className = 'dt-center', targets = 0:3))))

## ------------------------------------------------------------------------
pct.df <- ord.df %>% 
  group_by(station_id) %>% 
  mutate(total = sum(count),
         percent = count / total * 100) %>% 
  ungroup() %>% 
  tidyr::complete(order,
                  nesting(station_id, lake, total),
                  fill = list(count = 0, percent = 0)) %>% 
  mutate(lake = factor(lake, levels = c("onon", "ot", "caz")))

## ------------------------------------------------------------------------
env.df <- file.path("data",
                     "zms_thesis-env_2017-06-18.csv") %>% 
  read.csv(stringsAsFactors = FALSE) %>% 
  mutate(station_id = stringr::str_sub(unique_id, 1, -3)) %>% 
  select(-unique_id) %>% 
  distinct()

DT::datatable(env.df, options = list(scrollX = TRUE))

## ------------------------------------------------------------------------
ggplot(pct.df)

pct.df %>% 
  ggplot()

## ------------------------------------------------------------------------
pct.df %>% 
ggplot(aes(x = lake, y = percent))

## ------------------------------------------------------------------------
pct.df %>%
  filter(order == "ephemeroptera") %>% 
ggplot(aes(x = lake, y = percent)) +
  geom_boxplot()

## ------------------------------------------------------------------------
pct.df %>%
  filter(order == "ephemeroptera") %>% 
ggplot(aes(x = lake, y = percent, fill = lake)) +
  geom_boxplot()

## ------------------------------------------------------------------------
pct.df %>%
  filter(order == "ephemeroptera") %>% 
ggplot(aes(x = lake, y = percent, color = lake)) +
  geom_boxplot()

## ------------------------------------------------------------------------
pct.df %>%
  filter(order == "ephemeroptera") %>% 
ggplot(aes(x = lake, y = percent), color = lake) +
  geom_boxplot()

## ------------------------------------------------------------------------
pct.df %>%
  filter(order == "ephemeroptera") %>% 
ggplot(aes(x = lake, y = percent)) +
  geom_boxplot(aes(color = lake))

## ------------------------------------------------------------------------
pct.df %>%
  filter(order == "ephemeroptera") %>% 
ggplot(aes(x = lake, y = percent)) +
  geom_boxplot(color = c("purple", "orange", "brown"))

## ---- error=TRUE---------------------------------------------------------
pct.df %>%
  filter(order == "ephemeroptera") %>% 
ggplot(aes(x = lake, y = percent)) +
  geom_boxplot(aes(color = c("purple", "orange", "brown")))

## ------------------------------------------------------------------------
pct.df %>%
  filter(order == "ephemeroptera") %>% 
ggplot(aes(x = lake, y = percent), color = c("purple", "orange", "brown")) +
  geom_boxplot()

## ------------------------------------------------------------------------
pct.df %>%
  filter(order == "ephemeroptera") %>% 
ggplot(aes(x = lake, y = percent)) +
  geom_boxplot() +
  geom_point()

## ------------------------------------------------------------------------
pct.df %>%
  filter(order == "ephemeroptera") %>% 
ggplot(aes(x = lake, y = percent)) +
  geom_boxplot(outlier.shape = NA) +
  geom_jitter(aes(color = lake))

## ------------------------------------------------------------------------
pct.df %>%
  filter(order == "ephemeroptera") %>% 
ggplot(aes(x = lake, y = percent, color = lake)) +
  geom_boxplot(outlier.shape = NA) +
  geom_jitter()

## ------------------------------------------------------------------------
pct.df %>%
  filter(order == "ephemeroptera") %>% 
ggplot(aes(x = lake, y = percent, fill = lake)) +
  geom_violin()

## ---- fig.width=8--------------------------------------------------------
pct.df %>%
  filter(order == "ephemeroptera") %>% 
ggplot(aes(x = lake, y = percent, fill = lake)) +
  geom_dotplot(binaxis = "y",
               stackdir = "center",
               binwidth = 0.25)

## ---- fig.width=8--------------------------------------------------------
pct.df %>%
  filter(order == "ephemeroptera") %>% 
ggplot(aes(x = lake, y = percent)) +
  geom_boxplot(outlier.shape = NA) +
  geom_dotplot(aes(fill = lake),
               binaxis = "y",
               stackdir = "center",
               binwidth = 0.25)

## ------------------------------------------------------------------------
abund.df <- pct.df %>% 
  group_by(lake, order) %>% 
  summarise(count = median(count)) %>% 
  ungroup() %>% 
  mutate(order = forcats::fct_lump(factor(order),
                                   n = 5,
                                   w = count),
         order = forcats::fct_reorder(order, count, median, .desc = TRUE),
         lake = factor(lake, c("onon", "ot", "caz")))

DT::datatable(abund.df, options = list(scrollX = TRUE))

## ------------------------------------------------------------------------
abund.df %>% 
ggplot(aes(x = order, y = count)) +
  geom_bar(stat = "identity")

## ------------------------------------------------------------------------
abund.df %>% 
ggplot(aes(x = order, y = count, fill = lake)) +
  geom_bar(stat = "identity")

## ---- fig.width=8--------------------------------------------------------
abund.df %>% 
ggplot(aes(x = order, y = count, fill = lake)) +
  geom_bar(stat = "identity",
           position = "dodge")

## ---- fig.width=8--------------------------------------------------------
abund.df %>% 
  mutate(order = forcats::fct_reorder(order, count, median)) %>% 
ggplot(aes(x = lake, y = count, fill = order)) +
  geom_bar(stat = "identity",
           position = "stack")

## ---- fig.width=8--------------------------------------------------------
abund.df %>% 
  mutate(order = forcats::fct_reorder(order, count, median)) %>% 
ggplot(aes(x = lake, y = count, fill = order)) +
  geom_bar(stat = "identity",
           position = "fill")

## ---- fig.width=8--------------------------------------------------------
pct.df %>% 
  select(station_id, lake, percent, order) %>% 
  spread(order, percent) %>% 
ggplot(aes(x = diptera, y = amphipoda)) +
  geom_point()

## ---- fig.width=8--------------------------------------------------------
pct.df %>% 
  select(station_id, lake, percent, order) %>% 
  spread(order, percent) %>% 
ggplot(aes(x = diptera, y = amphipoda)) +
  geom_point(aes(color = lake))

## ---- fig.width=8--------------------------------------------------------
pct.df %>% 
  select(station_id, lake, percent, order) %>% 
  spread(order, percent) %>% 
ggplot(aes(x = diptera, y = amphipoda)) +
  geom_point(aes(color = lake)) +
  geom_line()

## ---- fig.width=8--------------------------------------------------------
pct.df %>% 
  select(station_id, lake, percent, order) %>% 
  spread(order, percent) %>% 
ggplot(aes(x = diptera, y = amphipoda)) +
  geom_point(aes(color = lake)) +
  geom_smooth(method = "lm", formula = y ~ x)

## ---- fig.width=8--------------------------------------------------------
pct.df %>% 
  select(station_id, lake, percent, order) %>% 
  spread(order, percent) %>% 
ggplot(aes(x = diptera, y = amphipoda, color = lake)) +
  geom_point() +
  geom_smooth(method = "lm", formula = y ~ x)

## ---- fig.width=8--------------------------------------------------------
pct.df %>% 
  select(station_id, lake, percent, order) %>% 
  spread(order, percent) %>% 
ggplot(aes(x = diptera, y = amphipoda)) +
  geom_point(aes(color = lake)) +
  geom_smooth(method = "loess", formula = y ~ x)

## ---- fig.width=8--------------------------------------------------------
pct.df %>% 
  select(station_id, lake, percent, order) %>% 
  spread(order, percent) %>% 
ggplot(aes(x = diptera, y = amphipoda, color = lake, fill = lake)) +
  geom_point(aes(color = lake)) +
  geom_smooth(method = "loess", formula = y ~ x)

## ---- fig.width=8, fig.height=20-----------------------------------------
pct.df %>% 
  select(station_id, lake, percent, order) %>% 
  spread(order, percent) %>% 
  gather(order, count, amphipoda:veneroida, -diptera) %>% 
ggplot(aes(x = diptera, y = count, color = lake, fill = lake)) +
  geom_point(aes(color = lake)) +
  geom_smooth(method = "loess", formula = y ~ x, se = FALSE) + 
  facet_wrap(~order,
             ncol = 1,
             scales = "free")

