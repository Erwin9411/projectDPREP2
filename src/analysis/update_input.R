# Copy output from data-preparation into input folder 
# This step really depends no how files are shared across the different stages (e.g. if whole pipeline
# is on a single machine, could directly access output folder from preparation stage)

####### Create Gen directory ######
dir.create("./gen/analysis/input", recursive = TRUE)

###### Read in data ################

complete_dataset <- load("./gen/data-preparation/output/comparison_dataset_complete.RData") 

###### Save data file ######
save(complete_dataset,file="./gen/analysis/input/complete_dataset.RData")
