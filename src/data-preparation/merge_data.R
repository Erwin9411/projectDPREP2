# Load datasets into R 
library(tibble)
library(readr)
df1 <- read.csv("../../gen/data-preparation/input/data_bol.csv", header = TRUE, sep = ",", fileEncoding="utf8")
df2 <- read.csv("../../gen/data-preparation/input/data_amazon.csv", header = TRUE, sep = ",", fileEncoding="utf8")

# Merge on id
df_joined <- full_join(df1,df2, by = character())

# Save merged data
save(df_joined,file="../../gen/data-preparation/temp/data_merged.RData")

