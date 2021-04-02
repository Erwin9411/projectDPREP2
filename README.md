# The E-Commerce Retail Market - Bol.com versus Amazon.nl

__Bol.com and Amazon.nl on the Dutch E-commerce retail market. Does price influence perceived quality?__

## Motivation

Amazon.nl is making its appearance on the e-commerce retail market in the Netherlands. Bol.com is one of the  bigger parties on the Dutch e-commerce retail market at  the moment. Both companies sell a wide variety of  products including smartphones. The goal of this project is to look if the price of a smartphone has influence on the perceived quality of that smartphone. The perceived quality will be measured by star rating. 
So the research question will be:  "To what extent does the product price of smartphones on bol.com and Amazon.nl have an impact on their perceived quality?"

## Method and results

### Method

The method that is chosen is linear regression. This method is used to predict the influence of the independent variable price on the dependent variable perceived quality. Perceived quality is expressed in the star-rating. By using linear regression there can, or can not, be concluded if there is a correlation between the variables and what the exact linear regression is. With this information the research question is answered. 

### Results

Based on the results of the linear regression for both bol.com and Amazon.nl the following results can be derived:
In general for both bol.com and Amazon.nl, higher prices achieve higher product ratings. However, for both firms cheaper products still receive quite high ratings. 

For Amazon.nl the data is more concentrated for products up to approximately €500,- and for bol.com this is up to approximately €1.000,-. The data of bol.com is more scattered than for Amazon.nl. But looking at both regression lines it can be seen that the regression line of bol.com lays higher than Amazon.nl which might indicate that the ratings of bol.com are in general higher than for Amazon.nl.

#### Model fit

As for the model fit, both the models have a relatively low R square (0.061 for bol.com  and 0.039 for Amazon.nl). This means that 6.1% and 3.9% of the variation in product ratings for bol.com and Amazon.nl is explained by the model, which is price. Moreover, the significance level for both bol.com and Amazon.nl for ‘price’ is below 0.01. This means that H0 can be rejected, which indicates that price has a significant impact on product ratings.

#### Conclusions and limitations

To conclude, price does have a significant impact on product ratings for smartphones on bol.com and Amazon.nl. However, covariates have not been taken into account since this is not in the scope of this research. These covariates are variables that influence the outcome of this model, and have an impact on star rating as well. These include product specifications, year, brand, product version, perceived brand positioning and so on. For future research, it is advised that these variables are taken into account.

veel meer factoren die een rol spelen die de perceived quality beinvloeden, deze covvariance zijn niet meegenomen in het onderzoek
Vervolg onderzoek dit wel mee in acht nemen: bijvoorbeld, product specificaties, jaar van uitbrengen, versie, merk, marketshare, perceived brand positioning, expectations

## Repository overview

Provide an overview of the directory structure and files.

There is a makefile that has to be runned to start to make all the maps up to date. This will result in the creation of the map 'gen'.
In the data map the data from both bol.com and Amazon is stored. THe csv files from the webscraper.
In the map source ('src') the code to preparate the data is stored. in 'data-preperation' the coude is store for the cleaning and preparation of the data. In the analysis are the regressions stored


## Running instructions

Explain to potential users how to run/replicate your workflow. Touch upon, if necessary, the required input data, which (secret) credentials are required (and how to obtain them), which software tools are needed to run the workflow (including links to the installation instructions), and how to run the workflow. Make use of subheaders where appropriate.
pip https://pypi.org/project/pip/

Rstudio https://tilburgsciencehub.com/get/r
The following packages:
ggplot
ggplot2
ggfortify
broom
dplyr
tibble
readr
stringr
tidyverse
tidyr
stargazer

The required data is already available, make connected. 


Git https://tilburgsciencehub.com/get/git

Make https://tilburgsciencehub.com/get/make


To run/replicate the workflow you have to run the makefile. 

## More resources

Point interested users to any related literature and/or documentation.

An aspect that is related to this research is the price-quality inference. This is a psychological aspect of pricing where there is a preference for a more expensive option. The aspect states that a higher price signals that the perceived quality is better (Smith, 2021). This is an aspect that might be related to the research and therefore might be interesting for interested users. 

## About

This project is performed by project group 8 of the Data Preperation and Worklfow Managment course of the TISEM department of Tilburg University. The project is done in the spring 2021 version of the course. The project was part of a team project performed by Marketing Analytics master students. Professor Hannes Datta contributed by providing helpful feedback during project feedback meetings. 

## Bibliography

Smith, R. (2021). Strategic Pricing., (pp. 46-53). Tilburg.
Tilburg sciencehub...




