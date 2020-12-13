12 + 21

# instala y actualiza

install.packages("tidyverse")

q <- 12

abc <- function(x, y){
  x * y - y
}

abc(x = 12, y = 4)

plot(c(1, 2, 3, 4))

library(tidyverse)
data("midwest", package = "ggplot2")

gg  <- ggplot(midwest, aes(x=area, y = poptotal)) +
        geom_point(aes(col = state, size = popdensity)) +
        geom_smooth(method = "loess", se = F) +
        xlim(c(0, 0.1)) +
        ylim(c(0, 500000)) +
        labs(subtitle = "Area Vs Population",
             y = "Population",
             x = "Area",
             title = "Scatterplot",
             caption = "Source: midwest")
gg
