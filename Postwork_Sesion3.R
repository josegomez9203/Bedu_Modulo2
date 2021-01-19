suppressMessages(suppressWarnings(library(dplyr)))
library(ggplot2)

url1 <- "https://www.football-data.co.uk/mmz4281/1718/SP1.csv"
url2 <- "https://www.football-data.co.uk/mmz4281/1819/SP1.csv"
url3 <- "https://www.football-data.co.uk/mmz4281/1920/SP1.csv"

download.file(url = url1, destfile = "1D_17_18.csv", mode = "wb")
download.file(url = url2, destfile = "1D_18_19.csv", mode = "wb")
download.file(url = url3, destfile = "1D_19_20.csv", mode = "wb")

elementos <- c("1D_17_18.csv","1D_18_19.csv","1D_19_20.csv")

lista <- lapply(elementos, read.csv)

str(lista)
head(lista)
View(lista)
summary(lista)


lista <- lapply(lista, select, Date, HomeTeam, AwayTeam, FTHG, FTAG, FTR)

data<-do.call(rbind, lista)

data <- data %>% 
  mutate(Date = as.Date(Date,"%d/%m/%y"),FTHG = as.numeric(FTHG),FTAG = as.numeric(FTAG))

str(data)

##########################
# Con el último data frame obtenido en el postwork de la sesión 2, elabora tablas de frecuencias relativas 
# para estimar las siguientes probabilidades:
# La probabilidad (marginal) de que el equipo que juega en casa anote x goles (x=0,1,2,)

Casa <- table(data$FTHG)/sum(data$FTHG)
Casa

# La probabilidad (marginal) de que el equipo que juega como visitante anote y goles (y=0,1,2,)

Visita <- table(data$FTAG)/sum(data$FTAG)
Visita

# La probabilidad (conjunta) de que el equipo que juega en casa anote x goles y el equipo que juega 
# como visitante anote y goles (x=0,1,2,, y=0,1,2,)
tabla <- data %>% 
  select(FTHG,FTAG) %>% 
  table()

tabla2<- tabla/sum(tabla)


# Realiza lo siguiente:
# Un gráfico de barras para las probabilidades marginales estimadas del número de goles que anota el equipo de casa
hist((data$FTHG),probability = T,
     breaks = 8,
     xlim = range(0,8),
     ylim = range(0,.6),
     xlab = "Frecuencia",
     ylab = "Probabilidad",
     main = "Probabilidad de goles de equipo de casa",
     col = "blue")

# Un gráfico de barras para las probabilidades marginales estimadas del número de goles que anota el equipo visitante.
hist((data$FTAG),probability = T,
     breaks = 8,
     xlim = range(0,8),
     ylim = range(0,.6),
     xlab = "Frecuencia",
     ylab = "Probabilidad",
     main = "Probabilidad de goles de equipo visitante",
     col = "darkgreen")

# Un HeatMap para las probabilidades conjuntas estimadas de los números de goles que anotan el equipo de casa y el 
# equipo visitante en un partido.

tabla3<-as.data.frame(tabla2)

ggplot(tabla3, aes(x=FTHG, y = FTAG, fill = Freq))+
  geom_tile()+ 
  scale_fill_gradient(low = "darkblue", high = "red")+
  labs(x= "Equipo de casa",
       y = "Equipo visitante",
       title = "HeatMap de probabilidades conjuntas estimadas del numero de goles")



