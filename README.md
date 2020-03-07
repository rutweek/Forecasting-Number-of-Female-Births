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




# Forecasting Process
##Define Goal
##Get Data
## Explore and Visualize Series
###Evaluating Predictability : Using AR(1) model
###Evaluating Predictability : Using Acf() function with 1st differencing:
###Time Series Components:
###Autocorrelation of entire time series
##Step 4: Preprocess Data
##Step 5: Partitioning of Time Series
##Step 6: Applying Forecasting Methods

###1. Seasonal Naive

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
