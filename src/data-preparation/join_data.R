dir.create("./gen/data-preparation/output", recursive = TRUE)
####################### Joining data#####################
#packages
library(tibble)
library(readr)
library(stringr)
library(tidyverse)
library(tidyr)
library(dplyr)


data_bol <- load("./gen/data-preparation/temp/bol_data_cleaned.RData")
data_amazon <- load("./gen/data-preparation/temp/amazon_data_cleaned.RData")

#Joining the both datasets ########
brands_bol <- data.frame(unique(bol_dataset$brand))
colnames(brands_bol) <- c("brand")

amazon_comparison_data <- amazon_dataset %>% inner_join(brands_bol, amazon_dataset, by = "brand")
amazon_comparison_data$site <- c("amazon.nl")
amazon_comparison_data$model <- c(NA)
amazon_comparison_data$EAN <- c(NA)

amazon_brands <- data.frame(unique(amazon_comparison_data$brand))
colnames(amazon_brands) <- c("brand")

bol_comparison_data <- bol_dataset %>% inner_join(amazon_brands, bol_dataset, by = "brand")
bol_comparison_data$site <- c("bol.com")
bol_comparison_data$asin <- c(NA)

comparison_dataset_complete <- rbind(amazon_comparison_data, bol_comparison_data)

col_order <- c("site", "title", "brand", "price", "star_rating", "review_count", "model", "EAN", "asin", "date")
comparison_dataset_complete <- comparison_dataset_complete[,col_order]

################# Save data #######################

save(bol_comparison_data,file="./gen/data-preparation/output/data_bol_comparison.RData")
save(amazon_comparison_data,file="./gen/data-preparation/output/data_amazon_comparison.RData")
save(comparison_dataset_complete,file="./gen/data-preparation/output/comparison_dataset_complete.RData")
