import excel "/Users/MahnoorKhan1/Desktop/Course Documents/2nd Semester/ECON 661/Project/owid-covid-data.xlsx", sheet("Sheet1") firstrow

save "covid.dta"

count if continent == "North America"
25,591

count if location == "United States"
793

count if location == "Canada"
792

//Canada only
drop if location != "Canada"

drop weekly_icu_admissions weekly_icu_admissions_per_millio weekly_hosp_admissions weekly_hosp_admissions_per_milli total_tests new_tests total_tests_per_thousand new_tests_per_thousand

drop tests_units total_vaccinations people_vaccinated people_fully_vaccinated total_boosters new_vaccinations new_vaccinations_smoothed total_vaccinations_per_hundred people_vaccinated_per_hundred people_fully_vaccinated_per_hund total_boosters_per_hundred new_vaccinations_smoothed_per_mi new_people_vaccinated_smoothed new_people_vaccinated_smoothed_p

//y=new_cases: non-missing
*drop if y==.

//Create trend
gen t=_n

tsset t

tsline new_cases

//Stationarity Check: drift accounts for intercept; trend delta t; 
dfuller new_cases, regress //difference stationarity
dfuller new_cases, drift regress //drift or intercept
dfuller new_cases, drift lags(1) regress //lags or covariance stationarity
dfuller new_cases, drift lags(2) regress
dfuller new_cases, drift lags(7) regress
dfuller new_cases, drift lags(14) regress
dfuller new_cases, drift lags(21) regress
dfuller new_cases, trend regress //trend stationarity

//Don't need (i think)
//reg should have same tstat as for trend above
reg new_cases t
outreg2 using "t-new_cases.tex", label bdec(2) se sdec(2) ctitle ("New Cases against t")
predict uhat, resid
dfuller uhat
dfuller uhat, trend

tsline uhat

//Autocorrelation plot
ac new_cases

//Partial Autocorrelation plot
pac new_cases

//AR
arima new_cases, arima(1,0,0)
estat ic
//AIC=15056.24, BIC=115070.26 

arima new_cases, arima(2,0,0)
estat ic
//AIC= 14936.62, BIC=14955.31

arima new_cases, arima(3,0,0)
estat ic
//AIC=14833.64,  BIC=14857.01

arima new_cases, arima(4,0,0)
estat ic
//AIC=14817.94,  BIC=14845.99

arima new_cases, arima(5,0,0)
estat ic
//AIC=14819.83,  BIC=14852.55

arima new_cases, arima(6,0,0)
estat ic
//AIC=14782.65,  BIC=14820.05

arima new_cases, arima(7,0,0)
estat ic
//AIC=14736.06, BIC=14778.13

arima new_cases, arima(8,0,0)
estat ic
//AIC=14687.89, BIC=14734.64

arima new_cases, arima(9,0,0)
estat ic
//AIC=14512.97, BIC=14564.39

arima new_cases, arima(10,0,0)
estat ic
//AIC=14487.42 , BIC=14543.51

arima new_cases, arima(11,0,0)
estat ic
//AIC=14484.78, BIC=14545.55

arima new_cases, arima(12,0,0)
estat ic
//AIC=14486.42, BIC=14551.86

arima new_cases, arima(13,0,0)
estat ic
//AIC=14470.68, BIC=14540.8

arima new_cases, arima(14,0,0)
estat ic
//AIC=14471.98, BIC=14546.77

arima new_cases, arima(15,0,0)
estat ic
//AIC= 14463.97, BIC=14543.44

arima new_cases, arima(16,0,0)
estat ic
//AIC=14464.8, BIC=14548.94

arima new_cases, arima(17,0,0)
estat ic
//AIC=14466.74, BIC=14555.56. 

arima new_cases, arima(18,0,0)
estat ic
//AIC=14468.34, BIC=14561.83

arima new_cases, arima(19,0,0)
estat ic
//AIC=14468.03, BIC=14566.2

arima new_cases, arima(20,0,0)
estat ic
//AIC=14467.12, BIC=14569.96

arima new_cases, arima(21,0,0)
estat ic
//AIC=14417.31, BIC=14524.83

arima new_cases, arima(22,0,0)
estat ic
//AIC=14409.62***, BIC=14521.8***

arima new_cases, arima(23,0,0)
estat ic
//AIC=14411.62, BIC=14528.48

arima new_cases, arima(24,0,0)
estat ic
//AIC=14410.23, BIC=14531.77

arima new_cases, arima(25,0,0)
estat ic
//AIC=14409.95, BIC=14536.17

arima new_cases, arima(26,0,0)
estat ic
//AIC=14410.86, BIC=14541.75

************not below
arima new_cases, arima(27,0,0)
estat ic
//AIC= 991.6921, BIC=1058.738

arima new_cases, arima(28,0,0)
estat ic
//AIC= 991.6921, BIC=1058.738

arima new_cases, arima(29,0,0)
estat ic
//AIC= 991.6921, BIC=1058.738

arima new_cases, arima(30,0,0)
estat ic
//AIC= 991.6921, BIC=1058.738

//According to both AIC and BIC, the best most is second one with two lags.



//MA
arima new_cases, arima(0,0,1)
estat ic
//AIC=15701.54, BIC=15715.56

arima new_cases, arima(0,0,2)
estat ic
//AIC=15478.36, BIC=15497.05

arima new_cases, arima(0,0,3)
estat ic
//AIC=15213.94, BIC=15237.31

arima new_cases, arima(0,0,4)
estat ic
//AIC=15080.21, BIC=15108.26

arima new_cases, arima(0,0,5)
estat ic
//AIC=15077.78, BIC=15110.5

arima new_cases, arima(0,0,6)
estat ic
//AIC=15070.21, BIC=15107.61

arima new_cases, arima(0,0,7)
estat ic
//AIC=14920.05, BIC=14962.12

arima new_cases, arima(0,0,8)
estat ic
//AIC=14842.81, BIC=14889.55

arima new_cases, arima(0,0,9)
estat ic
//AIC=14826.13, BIC=14877.55

arima new_cases, arima(0,0,10)
estat ic
//AIC=14715.7, BIC=14771.79

arima new_cases, arima(0,0,11)
estat ic
//AIC=14716.55, BIC=14777.32

arima new_cases, arima(0,0,12)
estat ic
//AIC=14710.75, BIC=14776.19

arima new_cases, arima(0,0,13)
estat ic
//AIC=14664.58, BIC=14734.7

arima new_cases, arima(0,0,14)
estat ic
//AIC=14636.63, BIC=14711.43

arima new_cases, arima(0,0,15)
estat ic
//AIC=14621.63, BIC=14701.1

arima new_cases, arima(0,0,16)
estat ic
//AIC=14611.5, BIC=14695.64

arima new_cases, arima(0,0,17)
estat ic
//AIC=14599.04, BIC=14687.85

arima new_cases, arima(0,0,18)
estat ic
//AIC=14578.87, BIC=14672.36

arima new_cases, arima(0,0,19)
estat ic
//AIC=14559.69, BIC=14657.86

arima new_cases, arima(0,0,20)
estat ic
//AIC=14551.43***, BIC=14654.27***

arima new_cases, arima(0,0,21)
estat ic
//AIC=14452.27, BIC=14559.78

*******
arima new_cases, arima(0,0,22)
estat ic
//AIC= 991.6921, BIC=1058.738

arima new_cases, arima(0,0,23)
estat ic
//AIC= 991.6921, BIC=1058.738

arima new_cases, arima(0,0,24)
estat ic
//AIC= 991.6921, BIC=1058.738


//ARMA

arima new_cases, arima(1,0,1)
estat ic
//AIC=14823.39, BIC=14842.09

arima new_cases, arima(1,0,2)
estat ic
//AIC=14824.95, BIC=14848.33

arima new_cases, arima(1,0,3)
estat ic
//AIC=14788.92, BIC=14816.97

arima new_cases, arima(1,0,4)
estat ic
//AIC=14722.48, BIC=14755.2

arima new_cases, arima(1,0,5)
estat ic
//AIC=14716.16, BIC=14753.56

arima new_cases, arima(1,0,6)
estat ic
//AIC=14594.81, BIC=14636.88

arima new_cases, arima(1,0,7)
estat ic
//AIC=14595.9, BIC=14642.64


arima new_cases, arima(14,0,7)
estat ic
//AIC=14423.24, BIC=14530.76

arima new_cases, arima(21,0,7)
estat ic
//AIC=14373.32  BIC=14513.55***

arima new_cases, arima(21,0,14)
estat ic
//AIC=14362.79***, BIC=14535.74

arima new_cases, arima(22,0,14)
estat ic
//not feasible

arima new_cases, arima(21,0,21)
estat ic
//not feasible


////Forecasting
arima new_cases if t<=785, arima(22, 0, 0)

predict chat,dynamic(783)

//graph
tsline new_cases chat if t>775, xline(784)
*insample looks good

//loss funtion/Evaluation
gen fe = new_cases-chat
gen sfe = fe^2

//Add space for required obseravations
set obs `=_N+10'

replace t=_n

//w/o time cuz for all 
arima new_cases, arima(22, 0, 0)

predict chat_exante, dynamic(792) 

tsline chat chat_exante if t>780

drop chat fe sfe 

***Shukar works but is flat. Check other models + delay forecast + reload data + remake t


//ARMA
use "covid.dta", clear
drop if location != "Canada"
gen t=_n
tsset t

arima new_cases if t<=788, arima(21, 0, 7)

predict chat,dynamic(786) //again for loss evaluation

//graph
tsline new_cases chat if t>780, xline(787)

//Loss ftn
gen fe = new_cases-chat //residual
gen sfe = fe^2 //squared residual
//gen lfe= exp(fe/2)-(fe/2)-1 //linux
sum sfe //then sqrt
sum fe

//in sample
**RMSE=2026, St.dev=3e^36, min=0.042, max=1.96e^37 //only sqrt of first taken
**MAE=16, St.dev=2027, min=15350, max=27755

//Add space for required obseravations
set obs `=_N+10'

replace t=_n

//w/o time cuz for all 
arima new_cases, arima(21, 0, 7)

predict chat_exante, dynamic(792) 

tsline new_cases chat if t>782, xline(792)

*RMSE: difference, square, avg(/df), sqrt

**Alhumdulillah

//New data for exante evaluation only
import excel "/Users/MahnoorKhan1/Desktop/Course Documents/2nd Semester/ECON 661/Project/owid-covid-data-new.xlsx", sheet("Sheet1") firstrow


save "covid_new.dta"

drop if location != "Canada"
gen t=_n
tsset t
drop weekly_icu_admissions weekly_icu_admissions_per_millio weekly_hosp_admissions weekly_hosp_admissions_per_milli total_tests new_tests total_tests_per_thousand new_tests_per_thousand

drop tests_units total_vaccinations people_vaccinated people_fully_vaccinated total_boosters new_vaccinations new_vaccinations_smoothed total_vaccinations_per_hundred people_vaccinated_per_hundred people_fully_vaccinated_per_hund total_boosters_per_hundred new_vaccinations_smoothed_per_mi new_people_vaccinated_smoothed new_people_vaccinated_smoothed_p

arima new_cases, arima(21, 0, 7) 
predict chat,dynamic(792) //Exante this time

//Loss ftn
gen fe = new_cases-chat //residual
gen sfe = fe^2 //squared residual
//gen lfe= exp(fe/2)-(fe/2)-1 //linux
sum sfe if t>792 //then sqrt
sum fe if t>792

//out of sample
**RMSE=2552, St.dev=4.02e^7, min=1.21, max=7.6e^8 //only sqrt of first taken
**MAE=98, St.dev=2553, min=-15496, max=27729
*RMSE 3316 dev:1.37e^7 min:164882 max:4.9e^7
*MAE 270 dev:3449 min:-6996 max:4563

**chat:prediction of new case in sample
**chat_exante: prediction of new case out of sample
**new_cases: actual case (that haven't yet occoured)

**no good for lfe, chat chat_exante same before prediction


//Evaluation
sum sfe if t>292
sum lfe if t>292

drop chat fe sfe lfe 



//AR
use "covid.dta", clear
drop if location != "Canada"
gen t=_n
tsset t

arima new_cases if t<=788, arima(22, 0, 0)

predict chat,dynamic(786) //again for loss evaluation (ex post)

*t<12061; dynamic(12059); tsline >12050

//graph
tsline new_cases chat if t>780, xline(787)

*gen fe=new_cases-chat
*gen sfe=fe^2 -> avg -> control for df = sum/n-k-1
*sum sfe if t>12059

//predictions in right direction
*gen cp= 

//Loss ftn//In sample
gen fe = new_cases-chat //residual
gen sfe = fe^2 //squared residual
//gen lfe= exp(fe/2)-(fe/2)-1 //linux

sum sfe
sum fe

//in sample
**RMSE=2092, St.dev=3.2e^7, min=0.056, max=7.6e^8 //only sqrt of first taken
**MAE=19, St.dev=2093, min=-15124, max=27523

//Add space for required obseravations
set obs `=_N+10'

replace t=_n

use "covid_new.dta", clear
drop if location != "Canada"
gen t=_n
tsset t

//w/o time cuz for all 
arima new_cases, arima(22, 0, 0)

predict chat_exante, dynamic(792) 
predict chat, dynamic(792) 

tsline new_cases chat if t>782, xline(792)

//Loss ftn
gen fe = new_cases-chat //residual
gen sfe = fe^2 //squared residual
//gen lfe= exp(fe/2)-(fe/2)-1 //linux
sum sfe if t>292
sum fe if t>292

//out of sample
**RMSE=3687, St.dev=1.8e^7, min=95350, max=6.57e^7 //only sqrt of first taken
**MAE=546, St.dev=3806, min=-8107, max=5331

//Evaluation
sum sfe if t>792
sum fe if t>792

drop chat fe sfe lfe 


//MA
use "covid.dta", clear
drop if location != "Canada"
gen t=_n
tsset t

arima new_cases if t<=788, arima(0, 0, 20)

predict chat,dynamic(786) //again for loss evaluation

//graph
tsline new_cases chat if t>780, xline(787)


//Loss ftn//In sample
gen fe = new_cases-chat //residual
gen sfe = fe^2 //squared residual
//gen lfe= exp(fe/2)-(fe/2)-1 //linux

sum sfe
sum fe

//in sample
**RMSE=2290, St.dev=3.6e^7, min=1.11, max=8.5e^8 //only sqrt of first taken
**MAE=18, St.dev=2291, min=-15745, max=29133


//Add space for required obseravations
set obs `=_N+10'

replace t=_n


use "covid_new.dta", clear
drop if location != "Canada"
gen t=_n
tsset t

//w/o time cuz for all 
arima new_cases, arima(0, 0, 20)

predict chat_exante, dynamic(792) 
predict chat, dynamic(792) 

tsline chat chat_exante if t>782, xline(792)

//Loss ftn
gen fe = new_cases-chat //residual
gen sfe = fe^2 //squared residual
//gen lfe= exp(fe/2)-(fe/2)-1 //linux


//Evaluation
sum sfe if t>792
sum lfe if t>792

drop chat fe sfe lfe 

//out of sample
**RMSE=4183, St.dev=1.7e^7, min=2078277, max=6.4e^7 //only sqrt of first taken
**MAE=722, St.dev=4307, min=-7999, max=4668


*****Maybe evaluate at end with actual data over this period
//install
ssc install xtoos
help xtoos_t

 xtoos_t, xtoos_i, xtoos_bin_t, and xtoos_bin_i
	  
	  
use "covid.dta", clear
drop if location != "Canada"
gen t=_n
tsset t

drop weekly_icu_admissions weekly_icu_admissions_per_millio weekly_hosp_admissions weekly_hosp_admissions_per_milli total_tests new_tests total_tests_per_thousand new_tests_per_thousand

drop tests_units total_vaccinations people_vaccinated people_fully_vaccinated total_boosters new_vaccinations new_vaccinations_smoothed total_vaccinations_per_hundred people_vaccinated_per_hundred people_fully_vaccinated_per_hund total_boosters_per_hundred new_vaccinations_smoothed_per_mi new_people_vaccinated_smoothed new_people_vaccinated_smoothed_p

arima new_cases if t<=788, arima(7, 0, 0)
predict chat,dynamic(786)
tsline new_cases chat if t>780, xline(787)
gen fe=new_cases-chat
gen sfe=fe^2 -> avg -> control for df = sum/n-k-1
sum sfe if t>786
drop chat fe sfe 


**Check ARMA(9,1)
*RMSE: difference, square, avg(/df), sqrt

//Friedman Statistical Test
ssc install emh


//Epidemiology/SIR
use "covid.dta", clear
drop if location != "Canada"

ssc install epimodels

db epi_sir

*need beta, gamma

epi_sir, beta(0.50) gamma(0.33333) susceptible(38060860) infected(7053) recovered(0) days(10) day0(2022-03-24) steps(1) clear scheme(s2color8) colormodel








