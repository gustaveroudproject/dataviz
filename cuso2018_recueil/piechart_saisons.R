# inspired by 
# https://s-media-cache-ak0.pinimg.com/736x/22/1a/d0/221ad079e362ba13969b1bef30b6a5f2.jpg

library(plotly)


setwd("/home/espadini/Github/elespdn/elespdn.github.io/talks/materials/20180524_cuso_recueil/AirSolitude_barchart/")


# read in data
df <- read.csv("list_prepublication_pie.csv", stringsAsFactors = F)

# Arrange in increasing order of emissions
df <- df %>% dplyr::arrange(Emission)
df <- df[-(1:50),]

#  Add colors
colors <- RColorBrewer::brewer.pal(length(unique(df$Continent)), "Spectral")
continent <- unique(df$Continent)

df$colors <- df$Continent

for(i in 1:length(continent)){
  idx <- df$colors %in% continent[i]   
  df$colors[idx] <- colors[i]
}

# Get incremental angle value
n <- nrow(df) + 0 ## CAMBIATA: ERA 20 !!!
dtheta <- 2*pi / n
theta <- pi / 2

# Initialise
x <- c()
y <- c()
xend <- c()
yend <- c()

# This is for the white - circle in the middle
adjust <- 50  ## CAMBIATO: ERA 20 !!!

# Calculate x and y coordinates
for(ctr in 1:nrow(df)){
  
  a <- df$Emission[ctr] + adjust
  
  x[ctr] <- adjust * cos(theta)
  y[ctr] <- adjust * sin(theta)
  
  xend[ctr] <- a * cos(theta)
  yend[ctr] <- a * sin(theta)
  
  theta <- theta + dtheta
}


plot.df <- data.frame(x, y, xend, yend, continent = df$Continent)

p <- plot_ly(plot.df, 
             x = ~x, y = ~y,
             xend = ~xend, yend = ~yend,
             color = ~continent) %>% 
  add_segments(line = list(width = 50)) # SPESSORE SEGMENTI

# Add layout options, shapes etc
p <- layout(p,
            xaxis = list(domain = c(0, 0.5), title = "", showgrid = F, zeroline = F, showticklabels = F),
            yaxis = list(title = "", showgrid = F, zeroline = F, showticklabels = F),
            shapes = list(
              list(type = "circle",
                   x0 = (-5 - adjust),
                   y0 = (-5 - adjust),
                   x1 = (5 + adjust),
                   y1 = (5 + adjust),
                   fillcolor = "transparent",
                   line = list(color = "white", width = 2)),
              
              list(type = "circle",
                   x0 = (-15 - adjust),
                   y0 = (-15 - adjust),
                   x1 = (15 + adjust),
                   y1 = (15 + adjust),
                   fillcolor = "transparent",
                   line = list(color = "white", width = 2)),
              
              list(type = "circle",
                   x0 = (-25 - adjust),
                   y0 = (-25 - adjust),
                   x1 = (25 + adjust),
                   y1 = (25 + adjust),
                   fillcolor = "transparent",
                   line = list(color = "white", width = 2)),
              
              list(type = "circle",
                   x0 = (-35 - adjust),
                   y0 = (-35 - adjust),
                   x1 = (35 + adjust),
                   y1 = (35 + adjust),
                   fillcolor = "transparent",
                   line = list(color = "white", width = 2))),
            
            legend = list(x = 0.20, y = 0.47, font = list(size = 16)))

# Add annotations for country names
theta <- pi / 2 ## NON CAMBIARE
textangle <- 90  ## NON CAMBIARE

for(ctr in 1:nrow(df)){
  
  a <- df$Emission[ctr] + adjust
  a <- a + a/12
  
  x <- a * cos(theta)
  y <- a * sin(theta)
  
  if(ctr < 51) {xanchor <- "auto"; yanchor <- "auto"}
  if(ctr > 51 & ctr < 84) {xanchor <- "right"; yanchor <- "middle"}
  if(ctr > 84) {xanchor <- "left"; yanchor <- "middle"}
  
  p$x$layout$annotations[[ctr]] <- list(x = x, y = y, showarrow = F,
                                        text = paste0(df$Country[ctr]),
                                        textangle = textangle,
                                        xanchor = xanchor,
                                        yanchor = yanchor,
                                        font = list(family = "serif", color = "black", size = 16),
                                        borderpad = 0,
                                        borderwidth = 0)
  theta <- theta + dtheta
  textangle <- textangle - (180 / pi * dtheta)
  
  if(textangle < -90) textangle <- 90
}

# Titles and some other details


p
