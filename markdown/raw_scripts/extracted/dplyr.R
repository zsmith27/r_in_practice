## ------------------------------------------------------------------------
suppressPackageStartupMessages(
  library(dplyr)
)

## ------------------------------------------------------------------------
taxa.df <- file.path("data",
                     "zms_thesis-macro_2017-06-18.csv") %>% 
  read.csv(stringsAsFactors = FALSE)

DT::datatable(taxa.df, options = list(scrollX = TRUE))

## ------------------------------------------------------------------------
env.df <- file.path("data",
                     "zms_thesis-env_2017-06-18.csv") %>% 
  read.csv(stringsAsFactors = FALSE)

DT::datatable(env.df, options = list(scrollX = TRUE))

## ------------------------------------------------------------------------
taxa.df <- taxa.df %>% 
  rename(latitude = lat,
         longitude = long)

names(taxa.df)

## ------------------------------------------------------------------------
filter.df <- taxa.df %>% 
  filter(unique_id == "caz_1_1")

DT::datatable(filter.df, options = list(scrollX = TRUE))

## ------------------------------------------------------------------------
filter.df <- taxa.df %>% 
  filter(unique_id == "caz_1_1",
         order %in% c("ephemeroptera", "trichoptera"))

DT::datatable(filter.df, options = list(scrollX = TRUE))

## ------------------------------------------------------------------------
select.df <- filter.df %>% 
  select(unique_id, final_id, count)

knitr::kable(select.df)

## ------------------------------------------------------------------------
select.df <- taxa.df %>%
  filter(unique_id == "caz_1_1",
         order %in% c("ephemeroptera", "trichoptera")) %>% 
  select(unique_id, final_id, count)

knitr::kable(select.df)

## ------------------------------------------------------------------------
reorder.df <- taxa.df %>%
  filter(unique_id == "caz_1_1",
         order %in% c("ephemeroptera", "trichoptera")) %>% 
  select(final_id, unique_id, count)

knitr::kable(reorder.df)

## ------------------------------------------------------------------------
reorder.df <- taxa.df %>%
  filter(unique_id == "caz_1_1",
         order %in% c("ephemeroptera", "trichoptera")) %>% 
  select(lake, station_id, sample_number, everything())

DT::datatable(reorder.df, options = list(scrollX = TRUE))

## ------------------------------------------------------------------------
nondistinct.df <- taxa.df %>% 
  select(lake, station_id, sample_number)

DT::datatable(nondistinct.df, 
              options = list(columnDefs = list(list(className = 'dt-center', targets = 0:3))))

## ------------------------------------------------------------------------
distinct.df <- taxa.df %>% 
  select(lake, station_id, sample_number) %>% 
  distinct()

DT::datatable(distinct.df, 
              options = list(columnDefs = list(list(className = 'dt-center', targets = 0:3))))

## ------------------------------------------------------------------------
mutate.df <- taxa.df %>% 
  select(lake, station_id, sample_number) %>% 
  distinct() %>%
  filter(lake == "caz") %>% 
  mutate(new_id = paste(station_id, sample_number,
                        sep = "_"))

DT::datatable(mutate.df,
              options = list(columnDefs = list(list(className = 'dt-center', targets = 0:4))))

## ------------------------------------------------------------------------
mutate.df <- taxa.df %>% 
  select(lake, station_id, sample_number, date) %>% 
  distinct() %>%
  filter(lake == "caz") %>% 
  mutate(new_id = paste(station_id, sample_number,
                        sep = "_"),
         date_id = paste(new_id, date,
                         sep = "_"))

DT::datatable(mutate.df,
              options = list(columnDefs = list(list(className = 'dt-center', targets = 0:6))))

## ------------------------------------------------------------------------
group.df <- taxa.df %>%
  filter(unique_id %in% c("caz_1_1", "caz_1_2")) %>% 
  select(unique_id, final_id, count) %>% 
  group_by(unique_id)

knitr::kable(group.df)

## ------------------------------------------------------------------------
group.df <- taxa.df %>%
  filter(unique_id %in% c("caz_1_1", "caz_1_2")) %>% 
  select(unique_id, final_id, count) %>% 
  group_by(unique_id) %>% 
  mutate(total = sum(count))

knitr::kable(group.df)

## ------------------------------------------------------------------------
group.df <- taxa.df %>%
  filter(unique_id %in% c("caz_1_1", "caz_1_2")) %>% 
  select(unique_id, final_id, count) %>% 
  group_by(unique_id) %>% 
  mutate(total = sum(count),
         percent = count / total * 100)

knitr::kable(group.df)

## ------------------------------------------------------------------------
ungroup.df <- taxa.df %>%
  filter(unique_id %in% c("caz_1_1", "caz_1_2")) %>% 
  select(unique_id, final_id, count) %>% 
  group_by(unique_id) %>% 
  mutate(total = sum(count),
         percent = count / total * 100) %>% 
  ungroup()

knitr::kable(ungroup.df)

## ------------------------------------------------------------------------
sub.df <- taxa.df %>%
  filter(unique_id %in% c("caz_1_1", "caz_1_2")) %>% 
  select(unique_id, order, count) %>% 
  group_by(unique_id)  %>% 
  mutate(total = sum(count),
         percent = count / total * 100) %>% 
  ungroup()

knitr::kable(sub.df)

## ------------------------------------------------------------------------
summarize.df <- taxa.df %>%
  filter(unique_id %in% c("caz_1_1", "caz_1_2")) %>% 
  select(unique_id, order, count) %>% 
  group_by(unique_id, order) %>% 
  summarize(count = sum(count)) %>% 
  ungroup()

knitr::kable(summarize.df)

## ------------------------------------------------------------------------
summarize.df <- taxa.df %>%
  filter(unique_id %in% c("caz_1_1", "caz_1_2")) %>% 
  select(unique_id, order, count) %>% 
  group_by(unique_id, order) %>% 
  summarize(count = sum(count)) %>% 
  ungroup() %>% 
  group_by(unique_id) %>% 
  mutate(total = sum(count),
         percent = count / total * 100) %>% 
  ungroup()

knitr::kable(summarize.df)

## ------------------------------------------------------------------------
caz1.df <- taxa.df %>%
  filter(unique_id %in% c("caz_1_1", "caz_1_2")) %>% 
  select(unique_id, order, count)

order.df <- caz1.df %>% 
  group_by(unique_id, order) %>% 
  summarize(count = sum(count)) %>% 
  ungroup()

percent.df <- order.df %>% 
  group_by(unique_id) %>% 
  mutate(total = sum(count),
         percent = count / total * 100) %>% 
  ungroup()

## ------------------------------------------------------------------------
left.df <- left_join(taxa.df, env.df, by = "unique_id")

DT::datatable(left.df, options = list(scrollX = TRUE))

## ------------------------------------------------------------------------
right.df <- right_join(taxa.df, env.df, by = "unique_id")

DT::datatable(right.df, options = list(scrollX = TRUE))

## ------------------------------------------------------------------------
full.df <- taxa.df %>% 
  filter(lake == "onon") %>% 
  full_join(env.df, by = "unique_id")

DT::datatable(full.df, options = list(scrollX = TRUE))

## ------------------------------------------------------------------------
semi.df <- taxa.df %>% 
  filter(lake == "onon") %>% 
  semi_join(env.df, by = "unique_id")

DT::datatable(semi.df, options = list(scrollX = TRUE))

## ------------------------------------------------------------------------
sub.df <- taxa.df %>% 
  filter(lake == "onon")

anti.df <- anti_join(env.df, sub.df, by = "unique_id")

DT::datatable(anti.df, options = list(scrollX = TRUE))

## ------------------------------------------------------------------------
nest.df <- taxa.df %>% 
  filter(lake == "onon") %>% 
  nest_join(env.df, by = "unique_id")

DT::datatable(nest.df, options = list(scrollX = TRUE))

## ------------------------------------------------------------------------
onon.df <- taxa.df %>% 
  filter(lake == "onon")

otis.df <- taxa.df %>% 
  filter(lake == "ot")

caz.df <- taxa.df %>% 
  filter(lake == "caz")

## ------------------------------------------------------------------------
bind.df <- bind_rows(onon.df, otis.df)

DT::datatable(bind.df, options = list(scrollX = TRUE))

## ------------------------------------------------------------------------
hier.df <- onon.df %>% 
  select(phylum:species)

DT::datatable(hier.df, options = list(scrollX = TRUE))

## ------------------------------------------------------------------------
count.df <- onon.df %>% 
  select(unique_id, final_id, count)

DT::datatable(count.df, options = list(scrollX = TRUE))

## ------------------------------------------------------------------------
bind.df <- bind_cols(count.df, hier.df)

DT::datatable(bind.df, options = list(scrollX = TRUE))

