# Copy the raw data into input folder 
library(tibble)
library(readr)
library(stringr)
library(tidyverse)

data_amazon <- read.csv("../../data/amazon/data_amazon_phones_20210323.csv", header = FALSE, sep = ",", fileEncoding="utf8")

data_bol <- read.csv("../../data/bol/data_bol.csv", header = FALSE, sep = " ", fileEncoding = "utf8", flush = TRUE)

##################bol.com######################



#give column names
colnames(data_bol) <- c("title_name",
                        "title",
                        "brand_name",
                        "brand",
                        "model_name",
                        "model",
                        "price_name",
                        "price",
                        "star_rating_name",
                        "star_rating",
                        "EAN_name",
                        "EAN",
                        "date_name",
                        "date")

#clean columns
data_bol_column <- subset(data_bol, select = -c(title_name, brand_name, model_name, price_name, star_rating_name, EAN_name, date_name) )

#clean added comma's in all elements
data_bol_column$date = substr(data_bol_column$date,1,nchar(data_bol_column$date)-1)
data_bol_column$EAN = substr(data_bol_column$EAN,1,nchar(data_bol_column$EAN)-1)
data_bol_column$star_rating = substr(data_bol_column$star_rating,1,nchar(data_bol_column$star_rating)-1)
data_bol_column$price = substr(data_bol_column$price,1,nchar(data_bol_column$price)-1)
data_bol_column$model = substr(data_bol_column$model,1,nchar(data_bol_column$model)-1)
data_bol_column$brand = substr(data_bol_column$brand,1,nchar(data_bol_column$brand)-1)
data_bol_column$title = substr(data_bol_column$title,1,nchar(data_bol_column$title)-1)

bol_df <- data_bol_column

#fix star ratings

#split by (
#split_rating <- bol_df$star_rating()


#schrijf een review = 0


#split star scores









##################AMAZON######################

colnames(data_amazon) <- #c("title",
                           #"price",
                           #"tech",
                           #"other",
                           #"extra")

write.csv(data_bol,file="../../gen/data-preparation/input/data_bol.csv", row.names = FALSE)
write.csv(data_amazon,file="../../gen/data-preparation/input/data_amazon.csv", row.names = FALSE)



