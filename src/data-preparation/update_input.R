# Copy the raw data into input folder 
library(tibble)
library(readr)
data_amazon <- read.csv("C:/Users/prive/projectDPREP2/data/amazon/data_amazon.csv", header = FALSE, sep = ",", fileEncoding="utf8")

data_bol <- read.csv("C:/Users/prive/projectDPREP2/data/bol/data_bol.csv", header = FALSE, sep = ",", fileEncoding = "utf8")
colnames(data_bol) <- #c("title",
                        #"price",
                        #"star_rating",
                        #"date")

colnames(data_amazon) <- #c("title",
                           #"price",
                           #"tech",
                           #"other",
                           #"extra")

write.csv(data_bol,file="../../gen/data-preparation/input/data_bol.csv", row.names = FALSE)
write.csv(data_amazon,file="../../gen/data-preparation/input/data_amazon.csv", row.names = FALSE)



