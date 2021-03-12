# Copy the raw data into input folder 
# This step really depends no how files are shared across the different stages (e.g. if whole pipeline
# is on a single machine, could directly access data from data directory)
file.copy("./data/listings2016/june.csv","./gen/data-preparation/input/june2016.csv")
file.copy("./data/listings2016/july.csv","./gen/data-preparation/input/july2016.csv")
file.copy("./data/listings2016/august.csv", "./gen/data-preparation/input/august2016.csv")
