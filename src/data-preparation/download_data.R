# Download dataset 1
dir.create('./data/listings2016')  # Uncomment if need to create directory with R
download.file('http://data.insideairbnb.com/the-netherlands/north-holland/amsterdam/2016-06-03/visualisations/listings.csv','./data/listings2016/june.csv')

# Download dataset 2
dir.create('./data/listings2016')  # Uncomment if need to create directory with R
download.file('http://data.insideairbnb.com/the-netherlands/north-holland/amsterdam/2016-07-04/visualisations/listings.csv','./data/listings2016/july.csv')

# Download datatset 3
dir.create('./data/listings2016')
download.file('http://data.insideairbnb.com/the-netherlands/north-holland/amsterdam/2016-08-04/visualisations/listings.csv','./data/listings2016/august.csv')