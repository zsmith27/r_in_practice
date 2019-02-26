## ------------------------------------------------------------------------
library(ggplot2)

suppressPackageStartupMessages(
 library(dplyr) 
)

## ------------------------------------------------------------------------
taxa.df <- file.path("data",
          "zms_thesis-macro_2017-06-18.csv") %>% 
  read.csv(stringsAsFactors = FALSE)

## ------------------------------------------------------------------------
ord.df <- taxa.df %>% 
  select(unique_id, station_id, lake, genus, count) %>% 
  group_by(unique_id, station_id, lake, genus) %>% 
  summarize(count = sum(count)) %>% 
  ungroup() %>% 
  group_by(station_id, lake, genus) %>% 
  summarize(count = mean(count)) %>% 
  ungroup() %>% 
  filter(genus != "")

DT::datatable(ord.df, options = list(columnDefs = list(list(className = 'dt-center', targets = 0:3))))

## ------------------------------------------------------------------------
pct.df <- ord.df %>% 
  group_by(station_id) %>% 
  mutate(total = sum(count),
         percent = count / total * 100) %>% 
  ungroup() %>% 
  tidyr::complete(genus,
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
  filter(genus == "ephemeroptera") %>% 
ggplot(aes(x = lake, y = percent)) +
  geom_boxplot()

## ------------------------------------------------------------------------
pct.df %>%
  filter(genus == "ephemeroptera") %>% 
ggplot(aes(x = lake, y = percent, fill = lake)) +
  geom_boxplot()

## ------------------------------------------------------------------------
pct.df %>%
  filter(genus == "ephemeroptera") %>% 
ggplot(aes(x = lake, y = percent, color = lake)) +
  geom_boxplot()

## ------------------------------------------------------------------------
pct.df %>%
  filter(genus == "ephemeroptera") %>% 
ggplot(aes(x = lake, y = percent)) +
  geom_boxplot(aes(color = lake))

## ------------------------------------------------------------------------
pct.df %>%
  filter(genus == "ephemeroptera") %>% 
ggplot(aes(x = lake, y = percent), color = lake) +
  geom_boxplot()

## ------------------------------------------------------------------------
pct.df %>%
  filter(genus == "ephemeroptera") %>% 
ggplot(aes(x = lake, y = percent), color = c("purple", "orange", "brown")) +
  geom_boxplot()

## ------------------------------------------------------------------------
pct.df %>%
  filter(genus == "ephemeroptera") %>% 
ggplot(aes(x = lake, y = percent)) +
  geom_boxplot(color = c("purple", "orange", "brown"))

## ------------------------------------------------------------------------
pct.df %>%
  filter(genus == "ephemeroptera") %>% 
ggplot(aes(x = lake, y = percent)) +
  geom_boxplot() +
  geom_point()

## ------------------------------------------------------------------------
pct.df %>%
  filter(genus == "ephemeroptera") %>% 
ggplot(aes(x = lake, y = percent)) +
  geom_boxplot(outlier.shape = NA) +
  geom_jitter(aes(color = lake))

## ------------------------------------------------------------------------
pct.df %>%
  filter(genus == "ephemeroptera") %>% 
ggplot(aes(x = lake, y = percent, fill = lake)) +
  geom_violin()

## ---- fig.width=8--------------------------------------------------------
pct.df %>%
  filter(genus == "ephemeroptera") %>% 
ggplot(aes(x = lake, y = percent, fill = lake)) +
  geom_dotplot(binaxis = "y",
               stackdir = "center",
               binwidth = 0.25)

## ---- fig.width=8--------------------------------------------------------
pct.df %>%
  mutate(genus = forcats::fct_reorder(genus, count, mean)) %>% 
ggplot(aes(x = lake, y = percent, fill = genus)) +
  geom_bar(stat = "identity",
           position = "fill")

## ---- fig.width=8--------------------------------------------------------
pct.df %>%
  mutate(genus = forcats::fct_reorder(genus, percent, mean)) %>% 
ggplot(aes(x = lake, y = percent, fill = genus)) +
  geom_bar(stat = "identity",
           position = "fill") +
  viridis::scale_fill_viridis(discrete = TRUE)

## ---- fig.width=8--------------------------------------------------------
pct.df %>%
  group_by(lake, genus) %>% 
  summarise(percent = mean(percent)) %>% 
  ungroup() %>% 
  mutate(genus = forcats::fct_lump(factor(genus),
                                   n = 5,
                                   w = percent),
         genus = forcats::fct_reorder(genus, percent, mean)) %>% 
ggplot(aes(x = lake, y = percent, fill = genus)) +
  geom_bar(stat = "identity",
           position = "fill") +
  viridis::scale_fill_viridis(discrete = TRUE)

## ------------------------------------------------------------------------
pct.df  %>% 
  filter(genus == "ephemeroptera") %>% 
  left_join(env.df, by = "station_id") %>%
  ggplot(aes(x = conductivity, y = percent)) +
  geom_line()

## ---- fig.width=8, fig.height=20-----------------------------------------
pct.df  %>% 
  # filter(genus == "veneroida") %>%
  left_join(env.df, by = "station_id") %>% 
  mutate(substrate = factor(substrate, levels = c("sand", "gravel", "coarsegravel", "cobble"))) %>% 
  ggplot(aes(x = substrate, y = percent, group = lake, fill = lake))+
  geom_col(position = "dodge") +
  facet_wrap(~genus, ncol = 1, scales = "free")

## ---- fig.width=8, fig.height=100----------------------------------------
pct.df  %>% 
  # filter(genus == "veneroida") %>% 
  left_join(env.df, by = "station_id") %>%
  ggplot(aes(x = substrate_size_d50, y = percent, group = lake, color = lake)) +
  geom_line()  +
  facet_wrap(~genus, ncol = 1, scales = "free")

