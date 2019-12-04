library(plotly)


setwd("/home/espadini/Github/elespdn/elespdn.github.io/talks/materials/20180524_cuso_recueil/AirSolitude_barchart/")

x = read.csv(file = "list_prepublication.csv", header = TRUE, stringsAsFactors = FALSE)[,1]
y = read.csv(file = "list_prepublication.csv", header = TRUE, stringsAsFactors = FALSE)[,4]
text = read.csv(file = "list_prepublication.csv", header = TRUE, stringsAsFactors = FALSE)[,2]
reprise = read.csv(file = "list_prepublication.csv", header = TRUE, stringsAsFactors = FALSE)[,8]
data <- data.frame(x, y, text, reprise)



m <- list(
  l = 70,
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
             text = ~text, textposition = 'none',
             type = 'bar',
             color = ~reprise,
             hoverinfo = 'x+text') %>%
  
  layout(title = "Gustave Roud, <i>Air de la solitude</i>, Mermod, Lausanne 1945", 
         xaxis = list(title = "", categoryarray = ~x, categoryorder = "array", tickangle = "-90"),
         yaxis = list(title = "Date de la pré-publication (1900)"),
         margin = m,
         #### plot_bgcolor = 'rgb(180, 180, 180)',
         font = ft,
         bargap = 0.4
         )

p
