# Forecasting Number of Female Births

## Summary
For the complete Time Series Analysis and Forecasting, all the steps were followed from data selection, exploring and visualizing the series and evaluating predictability, pre-processing of data, partitioning of time series, followed by generating numerous forecasting model, comparing the results of these models and then implementing the best model(s) for forecasting of data for 8 quarters in future, and deriving conclusions.

The methods used for forecasting / model generation were

* Seasonal Naive (as the base for comparison of accuracy results), 
* Moving Average - Trailing (with 4 different window widths), 
* Advanced Exponential Smoothing using Holt-Winter’s method, 
* Regression with Linear Trend, 
* Regression with Quadratic Trend, 
* Regression with Seasonality, 
* Regression with Linear Trend and Seasonality, 
* Regression with Quadratic Trend and Seasonality and 
* Auto ARIMA. 

The selection of these models was made based on the merit / demerit of each.
The forecasting results were quite promising with MAPE (Mean Absolute Percentage Error) being 2.789 and 2.809 and RMSE (Root Mean Square Error) as 115.073 and 122.954 for Regression with Linear Trend and Seasonality and Auto-ARIMA: (0,0,0)(1,1,0)[4] respectively. The data had seasonality in it with linear trend.

# Introduction
Quarterly data for female births of a region in New Zealand was selected. The data was taken from the website: https://timeseries.weebly.com/data-sets.html. The reason for selection of this dataset was that the prediction of number of births is extremely important for any government and most of its constituting bodies for medium and long term planning for infrastructural requirements like schools, teachers, utilities, commodities, etc. In addition to the government, many organizations depend heavily on birth estimates especially companies like Babies-R-Us, Toys-R-Us, Diaper manufacturing companies like Pampers, Huggies, etc., Strollers and Crib manufacturing companies like Graco, Cosco, and many other companies like Gerber, Carter, etc. We had data for both males births and female births, but we selected data on female births as the whole world is talking about female empowerment, female education, female liberty, etc. We checked the predictability of data for female births and found that it has some relevant components and is predictable.

Female births’ data was picked up for analysis and forecasting. The dataset had quarterly data for 10 years from 2000 - Q1 to 2012 - Q4 i.e. 48 historical data points, which was found satisfactory to prepare model and forecast the numbers of female births in the region for the next 2 years on a quarterly basis. It was decided that the accuracy for seasonal naive, a few regression models, some moving average model, some smoothing model and some ARIMA models will be checked subsequent to the development of the respective models, and then forecast for future will be done using the best model or best 2 models if 2 models are very close as far as accuracy is concerned.

# Forecasting Process
## Define Goal
The goal of this analysis was to forecast the number of births in a region of New Zealand for 8 quarters in future using one of the most optimum forecasting models applying the learnings of the Time Series Analysis and Forecasting Course and utilizing R as the software tool.
## Get Data
Quarterly data for female births of a region in New Zealand was taken from the website: https://timeseries.weebly.com/data-sets.html. The data had other columns too, but the relevant column only was copied on to the csv file (Births.csv) used as input for this analysis and forecasting. After putting the data in time series dataset, the following were the head and tail rows of the time series:
## Explore and Visualize Series
The first and foremost step in exploring and visualizing series was to see if the data is at all predictable, else the whole effort of forecasting will be a waste if the data is found to be a random walk / unpredictable. Hence, both the methods to analyze the predictability of data were applied as follows:
### Evaluating Predictability : Using AR(1) model
### Evaluating Predictability : Using Acf() function with 1st differencing:
### Time Series Components:
### Autocorrelation of entire time series
## Step 4: Preprocess Data
## Step 5: Partitioning of Time Series
## Step 6: Applying Forecasting Methods


### 1. Seasonal Naive

###2. Moving Average - Trailing

###3. Advanced Exponential Smoothing (Holt-Winter's Model)

###4. Regression Based Models

####i. Regression model with linear trend
####ii. Regression model with quadratic trend
####iii. Regression model with seasonality
####iv. Regression model with linear trend and seasonality
####v. Regression model with quadratic trend and seasonality
####Comparison
####5. Auto-Arima
##Step 7: Evaluation and Performance Comparison
##Step 8: Implementing Forecasts
###1. Regression model with linear trend and seasonality on entire dataset

###2. Auto-Arima on entire dataset
