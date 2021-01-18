suppressMessages(suppressWarnings(library(dplyr)))

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

data2 <- data %>% 
  mutate(Date = as.Date(Date,"%d/%m/%y"),FTHG = as.numeric(FTHG),FTAG = as.numeric(FTAG))

str(data2)
