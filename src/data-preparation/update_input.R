# Copy the raw data into input folder
library(readr)

###### Read in data ################
data_bol <- read.csv("./data/bol/data_bol.csv", header = FALSE, sep = " ", fileEncoding = "utf8", flush = TRUE)

data_amazon <- read.csv("./data/amazon/data_amazon_phones_202103.csv", header = FALSE, sep = " ", fileEncoding = "utf8", flush = TRUE)

###### Save data files ######
write.csv(data_bol,file="./gen/data-preparation/input/data_bol.csv", row.names = FALSE)

write.csv(data_amazon,file="./gen/data-preparation/input/data_amazon.csv", row.names = FALSE)


