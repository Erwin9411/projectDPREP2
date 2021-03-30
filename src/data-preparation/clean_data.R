# Load saved data

data_bol <- read.csv("./gen/data-preparation/input/data_bol.csv", header = TRUE, sep = ",", fileEncoding = "utf8", flush = TRUE)
data_amazon <- read.csv("./gen/data-preparation/input/data_amazon.csv", header = TRUE, sep = ",", fileEncoding="utf8", flush = TRUE)

################################### Clean data###############################
library(tibble)
library(readr)
library(stringr)
library(tidyverse)
library(tidyr)
library(dplyr)

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
#filter inbouwen
data_bol_column <- data_bol %>% filter(grepl("brand:", data_bol$brand_name))

#clean columns
data_bol_column <- subset(data_bol_column, select = -c(title_name, brand_name, model_name, price_name, star_rating_name, EAN_name, date_name) )

#brands to lower case
data_bol_column$brand <- tolower(data_bol_column$brand)


#clean added comma's in all elements
#function to do this
remove_last_char <- function(x) {
  substr(x,1,nchar(x)-1)
}

#actually doing it per data
data_bol_column$date <- remove_last_char(data_bol_column$date)
data_bol_column$EAN = remove_last_char(data_bol_column$EAN)
data_bol_column$star_rating = remove_last_char(data_bol_column$star_rating)
data_bol_column$price = remove_last_char(data_bol_column$price)
data_bol_column$model = remove_last_char(data_bol_column$model)
data_bol_column$brand = remove_last_char(data_bol_column$brand)
data_bol_column$title = remove_last_char(data_bol_column$title)
bol_df <- data_bol_column

#create star rating and review columns
#split by (
split_rating <- separate(data = bol_df, col = star_rating, into = c("star_rating", "review_count"), sep = "\\(")

#give number of reviews and star ratings
split_rating$review_count <- gsub("reviews)", "", split_rating$review_count)
split_rating$review_count <- gsub("review)", "", split_rating$review_count)
split_rating$review_count <- gsub("/\n", "", split_rating$review_count)
split_rating$review_count <- substr(split_rating$review_count,1,nchar(split_rating$review_count)-3)
split_rating$star_rating <- substr(split_rating$star_rating, 3, 5)

#split_rating$rating <- replace
split_rating$star_rating <- gsub(".nS", "Text", split_rating$star_rating)
split_rating$star_rating[ split_rating$star_rating == "Text" ] <- NA
split_rating[ split_rating == "null" ] <- NA
bol_dataset <- split_rating

#change class
bol_dataset$star_rating = as.numeric(as.character(bol_dataset$star_rating))
bol_dataset$review_count = as.numeric(as.character(bol_dataset$review_count))
bol_dataset$price <- gsub("-", "00", bol_dataset$price)
bol_dataset$price <- gsub(",", ".", bol_dataset$price)
bol_dataset$price = as.numeric(as.character(bol_dataset$price))
bol_dataset$date = as.Date(bol_dataset$date)

#Remove phones with only NA's
bol_dataset <- bol_dataset [!(is.na(bol_dataset$price)) | !(is.na(bol_dataset$review_count)) | !(is.na(bol_dataset$star_rating)) ,]



##################AMAZON######################

colnames(data_amazon) <- c("title_name",
                           "title",
                           "brand_name",
                           "brand",
                           "price_name",
                           "price",
                           "star_rating_name",
                           "star_rating",
                           "review_count_name",
                           "review_count",
                           "asin_name",
                           "asin",
                           "date_name",
                           "date")

#deleting uncessary columns
data_amazon_column <- subset(data_amazon, select = -c(title_name, brand_name, review_count_name, price_name, star_rating_name, asin_name, date_name))

#removing last commas
data_amazon_column$title = remove_last_char(data_amazon_column$title)
data_amazon_column$brand = remove_last_char(data_amazon_column$brand )
data_amazon_column$price = remove_last_char(data_amazon_column$price)
data_amazon_column$star_rating = remove_last_char(data_amazon_column$star_rating)
data_amazon_column$review_count = remove_last_char(data_amazon_column$review_count)
data_amazon_column$asin = remove_last_char(data_amazon_column$asin)
data_amazon_column$date = remove_last_char(data_amazon_column$date)

#transforming all to lower capitals
data_amazon_column$brand <- tolower(data_amazon_column$brand)

#deleting duplicates
data_amazon_column <- data_amazon_column %>% filter(!duplicated(data_amazon_column))

# change the null to NA's 
data_amazon_column$price[ data_amazon_column$price == "null" ] <- NA
data_amazon_column$review_count[ data_amazon_column$review_count == "null" ] <- NA
data_amazon_column$star_rating[ data_amazon_column$star_rating == "Vorige pagina gerelateerde Sponsored Products"] <- NA
data_amazon_column$star_rating[ data_amazon_column$star_rating == "null" ] <- NA
data_amazon_column$star_rating[ data_amazon_column$star_rating == "Previous page" ] <- NA
data_amazon_column$star_rating[ data_amazon_column$star_rating == "Terug" ] <- NA

#removing rows when price, start_rating and review_count is NA
data_amazon_column  <- data_amazon_column [!(is.na(data_amazon_column$price)) | !(is.na(data_amazon_column$review_count)) | !(is.na(data_amazon_column$star_rating)) ,]

#remove unnecessary information in cells
data_amazon_column$price <- gsub("\\u20ac", "", data_amazon_column$price)
data_amazon_column$price <- substr(data_amazon_column$price,2,nchar(data_amazon_column$price)-1)
data_amazon_column$review_count <- gsub(" beoordelingen", "", data_amazon_column$review_count)
data_amazon_column$star_rating <- gsub(" van 5 sterren", "", data_amazon_column$star_rating)

#improving data quality
data_amazon_column$brand <- gsub("de nokia store openen", "nokia", data_amazon_column$brand)
data_amazon_column$brand <- gsub("nokia c2-01", "nokia", data_amazon_column$brand)
data_amazon_column$brand <- gsub("lg g6 blue 32gb ss", "lg", data_amazon_column$brand)
data_amazon_column$brand <- gsub("lg electronics", "lg", data_amazon_column$brand)
data_amazon_column$brand <- gsub("motorola mobility", "motorola", data_amazon_column$brand)
data_amazon_column$brand <- gsub("samsung.", "samsung", data_amazon_column$brand)
data_amazon_column$brand <- gsub("oppo digital", "oppo", data_amazon_column$brand)
data_amazon_column$brand <- gsub("smart phone", "smartphone", data_amazon_column$brand)

#transforming price and starts to numeric
data_amazon_column$price <- gsub("[.]", "", data_amazon_column$price)
data_amazon_column$price <- gsub(",", ".", data_amazon_column$price)
data_amazon_column$price <- as.numeric(data_amazon_column$price)

data_amazon_column$star_rating <- gsub(",", ".", data_amazon_column$star_rating)
data_amazon_column$star_rating <- as.numeric(data_amazon_column$star_rating)

#transforming review_count to integer
data_amazon_column$review_count <- gsub("[.]", "", data_amazon_column$review_count)
data_amazon_column$review_count <- as.numeric(data_amazon_column$review_count)

#transforming date to date
data_amazon_column$date <- as.Date(data_amazon_column$date,format="%Y-%m-%d")
amazon_dataset <- data_amazon_column

######################### Save data #########################

save(bol_dataset,file="./gen/data-preparation/temp/bol_data_cleaned.RData")
save(amazon_dataset,file="./gen/data-preparation/temp/amazon_data_cleaned.RData")