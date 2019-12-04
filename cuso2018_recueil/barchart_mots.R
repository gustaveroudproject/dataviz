library(plotly)

setwd("/home/espadini/Github/elespdn/elespdn.github.io/talks/materials/20180524_cuso_recueil/AirSolitude_barchart/")

x = read.csv(file = "list_prepublication.csv", header = TRUE, stringsAsFactors = FALSE)[,1]
y = read.csv(file = "list_prepublication.csv", header = TRUE, stringsAsFactors = FALSE)[,9] # mots
text = read.csv(file = "list_prepublication.csv", header = TRUE, stringsAsFactors = FALSE)[,2]
journal = read.csv(file = "list_prepublication.csv", header = TRUE, stringsAsFactors = FALSE)[,5]
data <- data.frame(x, y, text, journal)



m <- list(
  l = 100,
  r = 10,
  b = 330,
  t = 40
)

ft <- list(
  family = "Serif",
  color = 'black',
  size = '18')

p <- plot_ly(data, 
             x = ~x, 
             y = ~y,
             type = 'bar',
             color = ~journal,
             text = ~text, textposition = 'none',
             hoverinfo = 'x+text') %>%
  
  layout(title = "Gustave Roud, <i>Air de la solitude</i>, Mermod, Lausanne 1945", 
         xaxis = list(title = "", categoryarray = ~x, categoryorder = "array", tickangle = "-90"),
         yaxis = list(title = "Mots par section"),
         margin = m,
         #### plot_bgcolor = 'rgb(180, 180, 180)',
         font = ft,
         bargap = 0.4
         )

p
