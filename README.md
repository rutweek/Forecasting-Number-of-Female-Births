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

<img src="TS PROJECT/GET DATA.jpg" width=300 height=300>

## Explore and Visualize Series
The first and foremost step in exploring and visualizing series was to see if the data is at all predictable, else the whole effort of forecasting will be a waste if the data is found to be a random walk / unpredictable. Hence, both the methods to analyze the predictability of data were applied as follows:

### Evaluating Predictability : Using AR(1) model
Here, the coefficient of the ar1 variable, 0.0818 which is well below 1 and even with confidence of 95%, the upper value of this coefficient will still be far below 1. Hence, it was inferred that births_f.ts is not a random walk and is predictable.

<img src="TS PROJECT/AR 1.jpg" width=600 height=300>


 


### Evaluating Predictability : Using Acf() function with 1st differencing:

<img src="TS PROJECT/AR 1 ACF.jpg" width=500 height=300>
Using the first differencing of the historical data and Acf() function the above plot was obtained, where autocorrelation coefficients for lag 2 and lag 4 are statistically significant. Hence, it was inferred that the time series is not a random walk, rather predictable.
Next summary of data was run to see if any outliers exist due to data entry errors or otherwise:

<img src="TS PROJECT/AR1 Summary.jpg" width=300 height=300>

It was found that the mean, median, quartiles values are all looking good and all were integers.No abnormality was found with the data including outliers.

### Time Series Components:

Then using stl() function various time series components were analyzed as below:

<img src="TS PROJECT/stl.jpg" width=600 height=300>

The plot above shows that there seems to be an upward trend and very strong seasonality. The data does not seem to be too levelled.
### Autocorrelation of entire time series
As seen in the graph below, autocorrelation coefficients for lag 2 and lag 4 are statistically significant. Especially, autocorrelation coefficient for lag 4 shows strong seasonality, however, that for lag 3 is almost negligible.

<img src="TS PROJECT/AR 1 ACF.jpg" width=600 height=300>

## Step 4: Preprocess Data
No data preprocessing was required as the data was found to be clean and straight-forward.

## Step 5: Partitioning of Time Series
It was decided to keep 3 years data i.e. total 12 quarterly periods in validation dataset and balance 10 years’ data in the training dataset, making validation dataset as around 23% of the entire time series data. 

## Step 6: Applying Forecasting Methods


### 1. Seasonal Naive
Seasonal Naive forecast was mainly used as a base for comparison. A table was prepared in the end comparing accuracy measures (MAPE and RMSE) for various forecasting methods. We can see baseline MAPE is 3.525 and RMSE is 162.697.

<img src="TS PROJECT/Seasonal Naive.jpg" width=300 height=100>

### 2. Moving Average - Trailing

<img src="TS PROJECT/Moving Average.jpg" width=500 height=300>

Models for Trailing Moving Averages were generated using rollmean() function with window width of 3, 4 , 5 and 6. It was sort of necessary to take window width of 4 as it was quarterly data. Accuracy measures were found using accuracy() function for all these models as shown above. As we can see the MAPE and RMSE for Training MA for window width 5, 5.385 and 255.223 respectively are the minimum amongst all Trailing MA models. The table at the end of this section compares the accuracy measures (MAPE and RMSE) for various forecasting methods including these.
### 3. Advanced Exponential Smoothing (Holt-Winter's Model)
Next Holt-Winter’s method was used with ets() function and model = “ZZZ” to get the system selected optimum model for error trend and seasonality. The model, as shown below resulted in multiplicative error, additive trend and additive seasonality (M,A,A), but with all, alpha (exponential smoothing constant), beta (smoothing constant for trend) and gamma (smoothing constant for seasonality) as negligible (all 0.0001). It means all the 3 components, error, trend and seasonal tend to be globally adjusted and does not change over time. The MAPE is 3.953 and RMSE is 168.451 .

<img src="TS PROJECT/AES.png" width=600 height=600>

### 4. Regression Based Models


#### i. Regression model with linear trend

<img src="TS PROJECT/Reg Linear Trend.jpg" width=600 height=600>

In the above model, though the trend coefficient is statistically significant and the p-value for F-statistic is also below 0.05, however, the R-squared values is only 0.1044. Hence, this model can not produce great forecast.
#### ii. Regression model with quadratic trend

<img src="TS PROJECT/Reg Quad Trend.jpg" width=600 height=600>


In the above model, both the trend and trend^2 coefficients are statistically insignificant, p-value for F-statistic is also 0.11 (statistically insignificant), also, R-squared is only 0.1113. Hence, this model can not be used for forecasting.


#### iii. Regression model with seasonality

<img src="TS PROJECT/Reg with Seasonality.jpg" width=600 height=600>

In this model, all the coefficients, for the 3 seasons and for F-statistic are statistically significant and R-squared is 0.7685, which is decent. Hence, this model can be used for forecasting and its equation can be given as: yt= 3223.2 + 198.5D2 + 743.1D3 + 169.2D3, where ytis the forecast for period t and D2, D3 and D4 are binary variables for Q2, Q3 and Q4.

#### iv. Regression model with linear trend and seasonality

<img src="TS PROJECT/Reg model with trend and seasonality.jpg" width=600 height=600>

In the above model, all the coefficients, for trend, the 3 seasons and for F-statistic are statistically significant and R-squared is 0.8518, which is pretty good. Hence, this model can be used for forecasting and its equation can be given as: yt= 3081.2 + 8t + 190.5D2 + 727.1D3 + 145.2D3, where yis the forecast for period t and D2, D3 and D4 are binary variables for Q2, Q3 and Q4.


#### v. Regression model with quadratic trend and seasonality

<img src="TS PROJECT/Reg model with quad treand and seasonality.jpg" width=600 height=600>

In the above model, the coefficients for trend, the 3 seasons and for F-statistic are statistically significant and R-squared is 0.858, which is pretty good. However, the coefficient for trend^2 is statistically insignificant with high p-value, which indicates that quadratic trend is missing in the data. But, this model can still be used for forecasting (subject to acceptable accuracy measures) and its equation can be given as: yt = 3021.19 + 16.6t - 0.21 t2 + 190.08D2 + 726.68D3 + 145.2D3, where ytis the forecast for period t and D2, D3 and D4 are binary variables for Q2, Q3 and Q4.


#### Comparison
The accuracy measures for the 5 regression models tried above are given below and we can see that the regression model with linear trend and seasonality has the minimum MAPE value of 2.789 and RMSE value of 115.073.

<img src="TS PROJECT/Reg model Comparison.jpg" width=600 height=500>
#### 5. Auto-Arima

Last but not the least, Auto-ARIMA method was used for model development and the results were sort of surprising. The model summary is presented below. The result though is a seasonal ARIMA model with 3 parentheses, with AR component with no trend, no differencing and no seasonality (p,d,q = 0) and with AR seasonal component of order 1 (P=1), with 1 differencing (D=1) and no MA component (Q=0). Last parenthesis shows quarterly data (4). There is a drift.

<img src="TS PROJECT/auto arima summary.jpg" width=600 height=300>

<img src="TS PROJECT/auto arima accuracy.jpg" width=600 height=300>

We can see that MAPE is 2.809 and RMSE is 122.954 for validation data, which is pretty low compared to the other models.

## Step 7: Evaluation and Performance Comparison
In the next step of forecasting process, accuracy measures for various forecasting methods tried above were compared. For moving average method, the best of the 4 models i.e. k=5 window width was taken for comparison. And for regression models, the best of the 5 models i.e. regression with linear trend and seasonality was taken for comparison:


<img src="TS PROJECT/final comparison.jpg" width=600 height=300>

<img src="TS PROJECT/comp summary.PNG" width=600 height=300>

From the above comparison table, it is evident that the best 2 models for forecasting are ‘Regression with Linear Trend and Seasonality’ and ‘Auto-ARIMA’. The difference in MAPE of the above 2 models is 0.02 only.

## Step 8: Implementing Forecasts
As discussed above, it was decided to forecast for the 2 years in the future using both the models which were near best. The forecast, taken for the entire dataset (training and validation periods combined) as produced are given below:


### 1. Regression model with linear trend and seasonality on entire dataset

<img src="TS PROJECT/forecast 1.jpg" width=600 height=300>


### 2. Auto-Arima on entire dataset

<img src="TS PROJECT/forecast 2.jpg" width=600 height=300>


# Conclusion
After utilizing 12 different models for forecasting (including 4 models with different window widths for Moving Averages and 5 models for regression), it was concluded that ‘Regression model with linear trend and seasonality’ was the best model for forecasting with a neck to neck competition with ‘Auto-ARIMA’ model. However, as Auto-ARIMA model resulted in many parameters as 0, it was felt that perhaps ‘Regression model with linear trend and seasonality’ should be used for forecasting the number of female births in the region.

The forecasting results were quite promising with MAPE (Mean Absolute Percentage Error) being 2.789 and 2.809 and RMSE (Root Mean Square Error) as 115.073 and 122.954 for Regression with Linear Trend and Seasonality and Auto-ARIMA: (0,0,0)(1,1,0)[4] respectively. The data had seasonality in it with linear trend.

Moving Average is usually used for data that lacks trend and seasonality. Since the data used in the project had liner trend and seasonality, moving averages method was not expected to give great results. As the data lacked quadratic or polynomial trend, quadratic trend with seasonality could not be used beneficially. Seasonal Naive was used as a base for comparison only. Holt-Winter’s model could have produced great results with trend and seasonality in the data, but found to have higher MAPE and RMSE as compared to better models.

This project was a great learning opportunity for the group as many challenges were faced in accomplishing the goals and overcoming those challenges enhanced the understanding on the subject. Initially data on number of natural and planted forests in a country were taken but after initial analysis it was found that the data is not predictable and hence, had to be dropped. Then the current dataset was used.

# Bibliography
1.	https://timeseries.weebly.com/data-sets.html: Data was downloaded data from this website
2.	PPTs, R Codes and Lecture Videos of Course ‘BAN673: Time Series Analytics and Forecasting’ by Prof. Zinovy Radovilsky.

