## Notes:
# - If run on unix system, use rm instead of del command in clean
# - Careful with spaces! If use \ to split to multiple lines, cannot have a space after \

# OVERALL BUILD RULES
all: data_cleaned results paper
#paper: gen/paper/output/paper.pdf
data_cleaned: gen/data-preparation/output/data_bol_comparison.RData gen/data-preparation/output/data_amazon_comparison.RData
results: gen/analysis/output/model_results.RData
.PHONY: clean

# INDIVIDUAL RECIPES

# Generate paper/text
#gen/paper/output/paper.pdf: gen/paper/output/table1.tex \
				#src/paper/paper.tex
	#pdflatex -interaction=batchmode -output-directory='gen/paper/output/' 'src/paper/paper.tex'
	#pdflatex -interaction=batchmode -output-directory='gen/paper/output/' 'src/paper/paper.tex'
	#pdflatex -output-directory='gen/paper/output/' 'src/paper/paper.tex'
# Note: runs pdflatex multiple times to have correct cross-references

# Generate tables
#gen/paper/output/table1.tex: gen/analysis/output/model_results.RData \
#				src/paper/tables.R
#	Rscript src/paper/tables.R

# Run analysis
gen/analysis/output/model_results.RData: gen/data-preparation/output/comparison_dataset_complete.RData \
						src/analysis/analyze.R
	Rscript src/analysis/update_input.R
	Rscript src/analysis/analyze.R

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
