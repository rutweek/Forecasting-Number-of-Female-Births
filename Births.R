 # USE FORECAST & ZOO LIBRARY.
library(forecast)
library(zoo)

### Step1 - Define Goal ###
#Done in report

### Step2 - Get Data ###
births.df <- read.csv(file.choose())
head(births.df)
tail(births.df)
births_f.ts <- ts(births.df$FemaleBirths, 
                   start = c(2000, 1), 
                   end = c(2012, 4), freq = 4)

### Step3 - Explore and Visualise Series ###

#Checking if our data is predictable:
#a. 
births.ar1<- Arima(births_f.ts, order = c(1,0,0))
summary(births.ar1)


#b.
diff.births <- diff(births_f.ts, lag = 1)
Acf(diff.births, lag.max = 4, 
    main = "Autocorrelation for First Differencing of Births Data")


summary(births.df)

#stl() 
births.stl <- stl(births_f.ts, s.window = "periodic")
autoplot(births.stl, main = "Births Time Series Component")

#Acf() 
autocor_NF <- Acf(births_f.ts, lag.max = 4, main = "Autocorrelation for Births")

### Step4 - Preprocessing ###
#No data preprocessing was required. 

### Step5 - Partition Series ###
nValid <- 12
nTrain <- length(births_f.ts) - nValid
train.ts <- window(births_f.ts, start = c(2000, 1), end = c(2000, nTrain))
valid.ts <- window(births_f.ts, start = c(2000, nTrain + 1), 
                   end = c(2000, nTrain + nValid))
train.ts
valid.ts

### Step6 - Forecasting Methods ###

## Data Driven 
## 1 : Seasonal Naive
births.snaive.pred <- snaive(train.ts, h = length(valid.ts))
round(accuracy(births.snaive.pred$mean, valid.ts), 3)

##2 : Moving Average - Trailing

ma.trailing_3 <- rollmean(births_f.ts, k = 3, align = "right")
ma.trailing_4 <- rollmean(births_f.ts, k = 4, align = "right")
ma.trailing_5 <- rollmean(births_f.ts, k = 5, align = "right")
ma.trailing_6 <- rollmean(births_f.ts, k = 6, align = "right")

round(accuracy(ma.trailing_3, births_f.ts), 3) 
round(accuracy(ma.trailing_4, births_f.ts), 3)
round(accuracy(ma.trailing_5, births_f.ts), 3)
round(accuracy(ma.trailing_6, births_f.ts), 3)

##3 : Advanced Exponential Smoothing (Holt-Winter's Model)
hw.ZZZ <- ets(train.ts, model = "ZZZ")
hw.ZZZ
hw.ZZZ.pred <- forecast(hw.ZZZ, h = nValid, level = 0)
round(accuracy(hw.ZZZ.pred$mean, valid.ts), 3)

## Model Driven 
##4 : Regression Based Models 

##4a : Regression model with linear trend.
train.trend <- tslm(train.ts ~ trend)
summary(train.trend)
train.trend.pred <- forecast(train.trend, h = nValid, level = 0)

##4b : Regression model with quadratic trend.
train.quad <- tslm(train.ts ~ trend + I(trend^2))
summary(train.quad)
train.quad.pred <- forecast(train.quad, h = nValid, level = 0)

##4c : Regression model with seasonality.
train.seas <- tslm(train.ts ~ season)
summary(train.seas)
train.seas.pred <- forecast(train.seas, h = nValid, level = 0)

##4d : Regression model with linear trend and seasonality.
train.trend.seas <- tslm(train.ts ~ trend + season)
summary(train.trend.seas)
train.trend.seas.pred <- forecast(train.trend.seas, h = nValid, level = 0)

##4e : Regression model with quadratic trend and seasonality.
train.quad.seas <- tslm(train.ts ~ trend + I(trend^2) + season)
summary(train.quad.seas)
train.quad.seas.pred <- forecast(train.quad.seas, h = nValid, level = 0)

#Comparision
round(accuracy(train.trend.pred$mean, valid.ts), 3)
round(accuracy(train.quad.pred$mean, valid.ts), 3)
round(accuracy(train.seas.pred$mean, valid.ts), 3)
round(accuracy(train.trend.seas.pred$mean, valid.ts), 3)
round(accuracy(train.quad.seas.pred$mean, valid.ts), 3)

#plotting 4d :  
plot(train.trend.seas.pred, 
     xlab = "Time", ylab = "Births", ylim = c(2900, 4300), bty = "l",
     xaxt = "n", xlim = c(2000, 2014), 
     main = "Linear Trend for Training and Validation Data", lwd = 2, flty = 5) 
axis(1, at = seq(2000, 2014, 1), labels = format(seq(2000, 2014, 1)))
lines(train.trend.seas.pred$fitted, col = "blue", lwd = 2)
lines(valid.ts, col = "black", lwd = 2, lty = 1)

lines(c(2010, 2010), c(2800, 4300))
lines(c(2012, 2012), c(2800, 4300))
text(2006, 4325, "Training")
text(2011, 4325, "Validation")
text(2013, 4325, "Future")
arrows(1999.5, 4280, 2010, 4280, code = 3, length = 0.1,
       lwd = 1, angle = 30)
arrows(2010, 4280, 2012, 4280, code = 3, length = 0.1,
       lwd = 1, angle = 30)
arrows(2012, 4280, 2014, 4280, code = 3, length = 0.1,
       lwd = 1, angle = 30)


##5 : Arima
train.auto.arima <- auto.arima(train.ts)
summary(train.auto.arima)

train.auto.arima.pred <- forecast(train.auto.arima, h = nValid, level = 0)
round(accuracy(train.auto.arima.pred, valid.ts), 3)

# plot
plot(train.auto.arima.pred, 
     xlab = "Time", ylab = "Births", ylim = c(2900, 4300), bty = "l",
     xaxt = "n", xlim = c(2000, 2014), 
     main = "Auto Arima", lwd = 2, flty = 5) 
axis(1, at = seq(2000, 2014, 1), labels = format(seq(2000, 2014, 1)))
lines(train.auto.arima.pred$fitted, col = "blue", lwd = 2)
lines(valid.ts, col = "black", lwd = 2, lty = 1)

lines(c(2010, 2010), c(2800, 4300))
lines(c(2012, 2012), c(2800, 4300))
text(2006, 4325, "Training")
text(2011, 4325, "Validation")
text(2013, 4325, "Future")
arrows(1999.5, 4280, 2010, 4280, code = 3, length = 0.1,
       lwd = 1, angle = 30)
arrows(2010, 4280, 2012, 4280, code = 3, length = 0.1,
       lwd = 1, angle = 30)
arrows(2012, 4280, 2014, 4280, code = 3, length = 0.1,
       lwd = 1, angle = 30)


### Step7 - Evaluate and compare performance ###

round(accuracy(births.snaive.pred$mean, valid.ts), 3) #1: Seasonal Naive
round(accuracy(hw.ZZZ.pred$mean, valid.ts), 3) #2 : Advanced Exponential Smoothing (Holt-Winter's Model)
round(accuracy(ma.trailing_5, births_f.ts), 3) #3 : Moving Averages
round(accuracy(train.trend.seas.pred$mean, valid.ts), 3) #4 : Regression model with linear trend and seasonality
round(accuracy(train.auto.arima.pred$mean, valid.ts), 3) #5 : Auto Arima


### Step8 - Implement Forecasts/System ###

#Regression model with linear trend and seasonality on Entire Dataset:
all.trend.seas <- tslm(births_f.ts ~ trend + season)
summary(all.trend.seas)
all.trend.seas.pred <- forecast(all.trend.seas, h = 8, level = 0)
round(all.trend.seas.pred$mean, 0)

#Auto Arima on entire Dataset:
auto.arima <- auto.arima(births_f.ts)
summary(auto.arima)
auto.arima.pred <- forecast(auto.arima, h = 8, level = 0)
round(auto.arima.pred$mean, 0)








