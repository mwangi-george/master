pacman::p_load(tidyverse)

iris %>% 
  group_by(Species) %>% 
  summarise_all(mean) -> iris_summary

iris %>% 
  ggplot(aes(Sepal.Length, 
             Sepal.Width, 
             color = Species))+
  geom_jitter(alpha = 0.6, 
              shape = 1)+
  geom_point(data = iris_summary, 
             shape =21, 
             size = 5,
             fill = "black",
             stroke = 2)+
  theme_classic()+
  labs(title = "Sepal.Width VS Sepal.Length",
       subtitle = "(source:ggplot2::irsis)")








# Plot base
plt_mpg_vs_fcyl_by_fam <- ggplot(mtcars, aes(fcyl, mpg, color = fam))

# Default points are shown for comparison
plt_mpg_vs_fcyl_by_fam + geom_point()

# Now jitter and dodge the point positions
plt_mpg_vs_fcyl_by_fam + geom_point(position = position_jitterdodge(jitter.width = 0.3, dodge.width =0.3))









# setting stat_bin
iris %>% 
  ggplot(aes(Sepal.Width, fill = Species)) +
  geom_histogram(binwidth = 0.1, center = 0.5)




iris %>% 
  select(Species, Sepal.Width) %>% 
  gather(key, value, -Species) %>% 
  group_by(Species) %>% 
  summarize(avg = mean(value),
            stdev = sd(value)) -> 
  iris1


iris %>% 
  select(Species, Sepal.Width) %>% 
  group_by(Species) %>% 
  summarize(avg = mean(Sepal.Width),
            stdev = sd(Sepal.Width)) ->
  iris2

iris %>% 
  select(Species, value = Sepal.Width) %>% 
  group_by(Species) %>% 
  summarize(avg = mean(value),
            stdev = sd(value)) ->
  iris3

ggplot(mtcars, aes(factor(cyl), fill = factor(am))) +
  geom_bar() +
  scale_fill_brewer(palette = "Set1")
economics



theme_set(theme_classic())



plt_prop_unemployed_over_time +
  theme(
    rect = element_rect(fill = "grey92"),
    legend.key = element_rect(color = NA),
    axis.ticks = element_blank(),
    panel.grid = element_blank(),
    panel.grid.major.y = element_line(
      color = "white",
      size = 0.5,
      linetype = "dotted"
    ),
    # Set the axis text color to grey25
    axis.text = element_text(color = "grey25"),
    # Set the plot title font face to italic and font size to 16
    plot.title = element_text(size = 16, face = "italic")
  )
rm(list = ls())











plt_prop_unemployed_over_time +
  theme_tufte() +
  theme(
    legend.position = "none",
    axis.ticks = element_blank(),
    axis.title = element_text(color = "grey60"),
    axis.text = element_text(color = "grey60"),
    # Set the panel gridlines major y values
    panel.grid.major.y = element_line(
      # Set the color to grey60
      color = "grey60",
      # Set the size to 0.25
      size= 0.25,
      # Set the linetype to dotted
      linetype = "dotted"
    )
  )