# initialize ####

library(tidyverse)

# Get the Data

polls <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-04-14/polls.csv')
rankings <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-04-14/rankings.csv')

# code for the rankings ####
# ranking <- polls %>% 
#   group_by(title, artist, year, gender) %>% 
#   summarise(
#     points = sum(points = (6 - rank) * 2), 
#     n = n(), 
#     n1 = sum(rank == 1),
#     n2 = sum(rank == 2),
#     n3 = sum(rank == 3),
#     n4 = sum(rank == 4),
#     n5 = sum(rank == 5)
#   ) %>% 
#   arrange(
#     desc(points), 
#     desc(n),
#     desc(n1), 
#     desc(n2), 
#     desc(n3), 
#     desc(n4), 
#     desc(n5)
#   ) %>%
#   rowid_to_column("ID")
# 
# ranking %>%
#   write_csv('data/rankings.csv', na = '')

# write the data to disk ####
# write_csv(polls, "./data/polls.csv")
# write_csv(rankings, "./data/rankings.csv")

# let's take a lil peak ####

ggplot(data = rankings) +
  geom_point(mapping = aes(x = year, y = points, color = gender), position = "jitter")

# i see a little bit of bias towards older songs. curious if this coincides with the age of the critics... either way let's make a heatmap

# as an extension of this, who's doing the best since the 2010s?

# i'm also curious to see the songs that <3 critics ranked #1. are these the sleeper hits