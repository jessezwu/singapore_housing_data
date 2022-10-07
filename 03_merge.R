library(magrittr)
library(tidyverse)

df = read_csv('data/resale-flat-prices-2017-training.csv')

streets = read_csv('data/geocoded_streets.csv')

df %<>% left_join(streets, by = c('street_name', 'town'))

df %>% write_csv('data/demo-resale-flat-prices-2017.csv')
