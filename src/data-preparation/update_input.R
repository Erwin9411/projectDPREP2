# Copy the raw data into input folder 
library(tibble)
library(readr)
library(stringr)
library(tidyverse)
library(tidyr)
library(dplyr)

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
#filter inbouwen
data_bol_column <- data_bol %>% filter(grepl("brand:", data_bol$brand_name))

#clean columns
data_bol_column <- subset(data_bol_column, select = -c(title_name, brand_name, model_name, price_name, star_rating_name, EAN_name, date_name) )

#brands to lower case
data_bol_column$brand <- tolower(data_bol_column$brand)


#clean added comma's in all elements
data_bol_column$date = substr(data_bol_column$date,1,nchar(data_bol_column$date)-1)
data_bol_column$EAN = substr(data_bol_column$EAN,1,nchar(data_bol_column$EAN)-1)
data_bol_column$star_rating = substr(data_bol_column$star_rating,1,nchar(data_bol_column$star_rating)-1)
data_bol_column$price = substr(data_bol_column$price,1,nchar(data_bol_column$price)-1)
data_bol_column$model = substr(data_bol_column$model,1,nchar(data_bol_column$model)-1)
data_bol_column$brand = substr(data_bol_column$brand,1,nchar(data_bol_column$brand)-1)
data_bol_column$title = substr(data_bol_column$title,1,nchar(data_bol_column$title)-1)
bol_df <- data_bol_column

#create star rating and review columns
#split by (
split_rating <- separate(data = bol_df, col = star_rating, into = c("rating", "review"), sep = "\\(")

#give number of reviews and star ratings
split_rating$review <- gsub("reviews)", "", split_rating$review)
split_rating$review <- gsub("review)", "", split_rating$review)
split_rating$review <- gsub("/\n", "", split_rating$review)
split_rating$review <- substr(split_rating$review,1,nchar(split_rating$review)-3)
split_rating$rating <- substr(split_rating$rating, 3, 5)
split_rating$rating <- replace
split_rating$rating <- gsub(".nS", "Text", split_rating$rating)
split_rating$rating[ split_rating$rating == "Text" ] <- NA
split_rating[ split_rating == "null" ] <- NA
bol_dataset <- split_rating

#change class
bol_dataset$rating = as.numeric(as.character(bol_dataset$rating))
bol_dataset$review = as.numeric(as.character(bol_dataset$review))
bol_dataset$price <- gsub("-", "00", bol_dataset$price)
bol_dataset$price <- gsub(",", ".", bol_dataset$price)
bol_dataset$price = as.numeric(as.character(bol_dataset$price))
bol_dataset$date = as.Date(bol_dataset$date)

#Remove phones with only NA's
bol_dataset <- bol_dataset [!(is.na(bol_dataset$price)) | !(is.na(bol_dataset$review)) | !(is.na(bol_dataset$rating)) ,]



##################AMAZON######################

data_amazon <- read.csv("../../data/amazon/data_amazon_phones_202103.csv", header = FALSE, sep = " ", fileEncoding="utf8", flush = TRUE)

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
data_amazon_column$title = substr(data_amazon_column$title,1,nchar(data_amazon_column$title)-1)
data_amazon_column$brand = substr(data_amazon_column$brand,1,nchar(data_amazon_column$brand)-1)
data_amazon_column$price = substr(data_amazon_column$price,1,nchar(data_amazon_column$price)-1)
data_amazon_column$star_rating = substr(data_amazon_column$star_rating,1,nchar(data_amazon_column$star_rating)-1)
data_amazon_column$review_count = substr(data_amazon_column$review_count,1,nchar(data_amazon_column$review_count)-1)
data_amazon_column$asin = substr(data_amazon_column$asin,1,nchar(data_amazon_column$asin)-1)
data_amazon_column$date = substr(data_amazon_column$date,1,nchar(data_amazon_column$date)-1)

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

#Joining the both datasets ########
brands_bol <- data.frame(unique(bol_dataset$brand))
colnames(brands_bol) <- c("brand")

amazon_data_comparison <- data_amazon_column %>% inner_join(brands_bol, data_amazon_column, by = "brand")

df_amazon_brands <- data.frame(unique(amazon_data_comparison$brand))
colnames(df_amazon_brands) <- c("brand")

bol_comparison_data <- bol_dataset %>% inner_join(df_amazon_brands, bol_dataset, by = "brand")



###### Save data files ######
#write.csv(bol_comparison_data,file="../../gen/data-preparation/input/comparison_data_bol.csv", row.names = FALSE)
write.csv(bol_dataset,file="../../gen/data-preparation/input/data_bol.csv", row.names = FALSE)

#write.csv(amazon_data_comparison,file="../../gen/data-preparation/input/comparison_data_amazon.csv", row.names = FALSE)
write.csv(amazon_dataset,file="../../gen/data-preparation/input/data_amazon.csv", row.names = FALSE)


