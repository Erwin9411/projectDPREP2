# BUILDING PLAN
all: data_cleaned analyze results 
data_cleaned: gen/data-preparation/output/data_bol_comparison.RData gen/data-preparation/output/data_amazon_comparison.RData
analyze: gen/analysis/input/complete_dataset.RData gen/analysis/input/data_amazon.RData gen/analysis/input/data_bol.RData
results: gen/analysis/output/regression_all_data.html gen/analysis/output/regression_by_site.html 

#Inspect data
gen/analysis/output/regression_all_data.html gen/analysis/output/regression_by_site.html: gen/analysis/input/complete_dataset.RData \
						src/analysis/regression_all_data.Rmd \
						gen/analysis/input/data_amazon.RData \
						gen/analysis/input/data_bol.RData \
						src/analysis/regression_by_site.Rmd 
	    R -e "rmarkdown::render('src/analysis/regression_all_data.Rmd', output_file = '../../gen/analysis/output/regression_all_data.html')"
	    R -e "rmarkdown::render('src/analysis/regression_by_site.Rmd', output_file = '../../gen/analysis/output/regression_by_site.html')"
        
# Start analyse
gen/analysis/input/complete_dataset.RData: gen/data-preparation/output/comparison_dataset_complete.RData  
	Rscript src/analysis/update_input.R

# Clean data
gen/data-preparation/output/data_bol_comparison.RData gen/data-preparation/output/data_amazon_comparison.RData: data/bol/data_bol.csv \
						data/amazon/data_amazon_phones_202103.csv \
						src/data-preparation/clean_data.R \
						src/data-preparation/join_data.R						
	Rscript src/data-preparation/update_input.R
	Rscript src/data-preparation/clean_data.R
	Rscript src/data-preparation/join_data.R
	

