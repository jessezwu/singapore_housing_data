library(tidyverse)

df <- read_csv('data/resale-flat-prices-based-on-registration-date-from-jan-2017-onwards.csv')

# change remaining lease field to a year duration numeric
# e.g. '00 years 06 months' -> 60.5
get_numeric_from_lease <- function(string, pattern=' ') {
  components = str_split(string, pattern)
  sapply(components, function(x) {
    year = as.numeric(x[1])
    month = as.numeric(x[3]) / 12
    sum(year, month, na.rm = TRUE)
  })
}

df %>%
  mutate(remaining_lease_years = get_numeric_from_lease(remaining_lease)) %>%
  select(-remaining_lease) %>%
  relocate(resale_price) %>%
  write_csv('data/resale-flat-prices-2017-training.csv')
