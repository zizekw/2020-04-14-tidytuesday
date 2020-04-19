# initialize ####

library(tidyverse)
library(gganimate)
library(viridis)
library(gt)

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

# let's make a heatmap of number of votes per release year i see a little bit of bias towards older songs. curious if this coincides with the age of the critics... 

years <- polls %>% 
          group_by(year) %>% 
          summarise(n = n())

ggplot(years, aes(n, year, fill = n)) + 
  geom_col(show.legend = FALSE) +
  scale_fill_viridis(discrete=FALSE) +
  scale_x_continuous(breaks = scales::pretty_breaks(n = 2), expand = c(0,1)) +
  scale_y_reverse(breaks = scales::pretty_breaks(n = 20), expand = c(0,0)) +
  theme_minimal() +
  labs(x="Number of Votes",
       # y="Release Year",
       # x="",
       y="",
       title = "Number of Critic Votes for Top Hip-hop Songs by the Song Release Year",
       subtitle = "BBC Music asked critics all over the world to rank their all time `Top 5` hip hop songs") +
  theme(plot.title = element_text(face = "bold"),
        plot.title.position = "plot",
        plot.caption.position = "plot",
        # axis.line = element_line(colour = "black", size = 0.5, linetype = "solid")
        ) +
  transition_states(
      year,
      transition_length = 50,
      state_length = 1) +
  shadow_mark()

# as an extension of this, who's doing the best since the 2010s? ####

# Let's have a look after 2000

ranking_new <- polls %>%
  filter(year > 1999) %>%
  group_by(title, artist, year, gender) %>%
  summarise(
    points = sum(points = (6 - rank) * 2),
    n = n(),
    n1 = sum(rank == 1),
    n2 = sum(rank == 2),
    n3 = sum(rank == 3),
    n4 = sum(rank == 4),
    n5 = sum(rank == 5)
  ) %>%
  arrange(
    desc(points),
    desc(n),
    desc(n1),
    desc(n2),
    desc(n3),
    desc(n4),
    desc(n5)
  ) %>%
  rowid_to_column("ID")

ggplot(data = ranking_new) +
  geom_point(mapping = aes(x = year, y = points, color = gender), position = "jitter")

# i'm also curious to see the songs that <3 critics ranked #1. are these the sleeper hits ####