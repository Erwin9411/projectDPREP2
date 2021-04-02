## Notes:
# - If run on unix system, use rm instead of del command in clean
# - Careful with spaces! If use \ to split to multiple lines, cannot have a space after \

# OVERALL BUILD RULES
all: data_cleaned analyze results 
data_cleaned: gen/data-preparation/output/data_bol_comparison.RData gen/data-preparation/output/data_amazon_comparison.RData
analyze: gen/analysis/input/complete_dataset.RData gen/analysis/input/data_amazon.RData gen/analysis/input/data_bol.RData
results: gen/analysis/output/regression_all_data.html gen/analysis/output/regression_by_site.html 
.PHONY: clean

# INDIVIDUAL RECIPES

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
	

# Clean-up: Deletes temporary files
# Note: Using R to delete files keeps platform-independence.
# 	    --vanilla option prevents from storing .RData output
clean:
	Rscript --vanilla src/clean-up.R
