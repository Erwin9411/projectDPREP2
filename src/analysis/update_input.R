# Copy output from data-preparation into input folder 
# This step really depends no how files are shared across the different stages (e.g. if whole pipeline
# is on a single machine, could directly access output folder from preparation stage)

####### Create Gen directory ######
dir.create("./gen/analysis/input", recursive = TRUE)

###### Read in data ################
load("./gen/data-preparation/output/comparison_dataset_complete.RData") 
complete_dataset <- comparison_dataset_complete
load("./gen/data-preparation/output/amazon_comparison_data.RData") 
data_amazon <- amazon_comparison_data
load("./gen/data-preparation/output/bol_comparison_data.RData") 
data_bol <- bol_comparison_data

###### Save data file ######
save(complete_dataset,file="./gen/analysis/input/complete_dataset.RData")
save(data_amazon,file="./gen/analysis/input/data_amazon.RData") 
save(data_bol, file="./gen/analysis/input/data_bol.RData") 