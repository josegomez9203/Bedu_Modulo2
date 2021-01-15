library(dplyr)


soccer_19_20<-read.csv("https://www.football-data.co.uk/mmz4281/1920/SP1.csv")

datos <- soccer_19_20 %>% 
  select(FTHG,FTAG)

?table


Casa <- table(datos$FTHG)/sum(datos$FTHG)
Casa
Visita <- table(datos$FTAG)/sum(datos$FTAG)
Visita

tabla <- table(datos)
tabla2 <- tabla/sum(tabla)
tabla2

sum(apply(tabla2, 1, sum))
sum(tabl)
