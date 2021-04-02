# The E-Commerce Retail Market - bol.com versus Amazon.nl

__Bol.com and Amazon.nl on the Dutch E-commerce retail market.
To what extent does the product price of smartphones on bol.com and Amazon.nl have an impact on their perceived quality?__

## Motivation

Amazon.nl is making its appearance on the e-commerce retail market in the Netherlands. Bol.com is one of the  bigger parties on the Dutch e-commerce retail market at  the moment. Both companies sell a wide variety of  products including smartphones. The goal of this project is to look if the price of a smartphone has influence on the perceived quality of that smartphone. The perceived quality will be measured by star rating. 
So the research question will be:  "To what extent does the product price of smartphones on bol.com and Amazon.nl have an impact on their perceived quality?"

## Method and results

### Method

The method that is chosen is linear regression. This method is used to predict the influence of the independent variable price on the dependent variable perceived quality. Perceived quality is expressed in the star-rating. By using linear regression there can, or cannot, be concluded if there is a correlation between the variables and what the exact linear regression is. With this information the research question is answered. 

### Results

Based on the results of the linear regression for both bol.com and Amazon.nl the following results can be derived:
In general for both bol.com and Amazon.nl, higher prices achieve higher product ratings. However, for both firms cheaper products still receive quite high ratings. 

For Amazon.nl the data is more concentrated for products up to approximately €500,- and for bol.com this is up to approximately €1.000,-. The data of bol.com is more scattered than for Amazon.nl. But looking at both regression lines it can be seen that the regression line of bol.com lays higher than Amazon.nl which might indicate that the ratings of bol.com are in general higher than for Amazon.nl.

#### Model fit

As for the model fit, both the models have a relatively low R square (0.061 for bol.com  and 0.039 for Amazon.nl). This means that 6.1% and 3.9% of the variation in product ratings for bol.com and Amazon.nl is explained by the model, which is price. Moreover, the significance level for both bol.com and Amazon.nl for ‘price’ is below 0.01. This means that H0 can be rejected, which indicates that price has a significant impact on product ratings.

#### Conclusions and limitations

To conclude, price does have a significant impact on product ratings for smartphones on bol.com and Amazon.nl. However, covariates have not been taken into account since this is not in the scope of this research. These covariates are variables that influence the outcome of this model, and have an impact on star rating as well. These include product specifications, year, brand, product version, perceived brand positioning and so on. For future research, it is advised that these variables are taken into account.

## Repository overview

There is a Make-file that has to run to make all the maps up to date. This will also result in the creation of the map 'gen'. More information on the running of the make file can be found in the running instructions paragraph. The maps that can be found in the repository are:

### Data

In the 'data' map the data from both bol.com and Amazon is stored. The data that is used are the csv-files derived from the web scraper.

### Gen
The gen map is the generated map with the outputs of the analysis (e.g. regression analysis output). This map is separated into two sub maps:
- In the map 'data-preparation' the input and the output is stored here. 
- In the map 'analysis' the output from the analysis of the data is stored.

### Source
In the map source ('src') the code to prepare the data is stored. This map is separated into two sub maps:
- In the map 'data-preparation' the code is stored for the cleaning and preparation of the data. 
- In the map 'analysis' the code is stored for the analysis of the data.

## Running instructions

To run the files Make is needed (https://tilburgsciencehub.com/get/make). The directory works with make which should be run. Also R-studio is needed (https://tilburgsciencehub.com/get/r) to run the R-files. Within R the following packages need to be installed:
-ggplot
-ggplot2
-ggfortify
-broom
-dplyr
-tibble
-readr
-stringr
-tidyverse
-tidyr
-stargazer
To  install these packages, pip is recommended (https://pypi.org/project/pip/).
Make sure to run the Make-file.

## More resources

An aspect that is related to this research is the price-quality inference. This is a psychological aspect of pricing where there is a preference for a more expensive option. The aspect states that a higher price signals that the perceived quality is better (Smith, 2021). This is an aspect that might be related to the research and therefore might be interesting for interested users. 

## About

This project is performed by project group 8 of the Data Preparation and Workflow Management course of the TISEM department of Tilburg University. The project is done in the spring 2021 version of the course. The project was part of a team project performed by Marketing Analytics master students. Professor Hannes Datta contributed by providing helpful feedback during project feedback meetings. 

## Bibliography

Smith, R. (2021). Strategic Pricing., (pp. 46-53). Tilburg.
Tilburg University. (2021). Tilburg Science Hub. Retrieved from Tilburg Science Hub: https://tilburgsciencehub.com/
