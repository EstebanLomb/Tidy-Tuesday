
# Tidy Tuesday 26-06

# Librerías
library("tidyverse")
library("data.table")
library('ggthemes') # visualisation
library('viridis') # visualisation
library('ggwordcloud') # text visuals
library("tidytuesdayR") 

# Data load
data <- tidytuesdayR::tt_load('2022-04-26')
data <- data[[1]]

# Graph
p1 <- data %>% 
  select(title) %>% 
  mutate(title = str_to_lower(title)) %>% 
  mutate(title = str_replace(title, "covid-19", "covid19"),
         title = str_replace(title, "visualizations", "visualization")) %>% 
  unnest_tokens(word, title) %>% 
  anti_join(stop_words, by = "word") %>% 
  count(word, sort = TRUE) %>% 
  head(45) %>% 
  filter(!(word %in% c("1", "2"))) %>%
  ggplot(aes(label = word, size = n/10, col = n)) +
  geom_text_wordcloud(seed = 4321) +
  scale_size_area(max_size = 20) +
  scale_color_viridis(begin = 0.3, end = 0.8, option = "B") +
  theme_void() +
  labs(title = "Most frequent words in tittles",
       subtitle = "Data: Kaggle Hidden Gems",
       caption = "Author: Esteban Lombeida  / @EstebanLomb")
p1

# Cite Pakage
citation("tidytuesdayR")
