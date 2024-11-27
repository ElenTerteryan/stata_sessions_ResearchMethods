cd "C:\Users\Admin\Desktop\research-stata\session #2"

*** Sample without replacement ***

// Sampling 10% of data
import delimited "hsb2.csv", clear
count
sample 10
count

// Sampling by specified number of observations
import delimited "hsb2.csv", clear
sample 50, count 
count

// Sampling more then our dataset size is
import delimited "hsb2.csv", clear
sample 250, count
count

// Sampling from each level of grouping (categorical) variable
import delimited "hsb2.csv", clear 
sort prog
by prog: count
by prog: sample 15
count
by prog:count

// Sampling by condition
import delimited "hsb2.csv", clear 
sort prog
by prog: count
sample 12 if prog == "vocational"
count
sort prog
by prog:count

import delimited "hsb2.csv", clear 
sample 12 if prog != "vocational"
sort prog
by prog: count


*** Sampling with replacement (bootstrap sampling)*** 
clear

input id wt strata1 cluster1  x
1 4 1 1 15
2 4 1 1 29
3 4 2 2 14
4 4 2 2 25
5 4 3 2 17
6 5 3 3 19
7 5 4 3 20
8 5 4 3 27
9 5 5 4 26
10 5 5 4 28
end

save "d:wrsample.dta", replace

bsample 5
list

// One observation per strata 
use "d:wrsample.dta", clear
bsample 1, strata(strata1)
list

// Sampling per cluster 
use "d:wrsample.dta", clear
bsample 3, cluster(cluster1)
list


*** Setting seed ***
sysuse auto, clear
set seed 123456
sample 5
list

*** Randomization ***
import delimited "StudentsPerformance.csv", clear

set seed 585506
gen random_number = runiform()
sort random_number
gen group = _n <= _N / 2
list gender raceethnicity parentallevelofeducation group in 1/20


*** Interaction between dummy variables ***
import excel "Dataset1.xlsx",firstrow clear
gen Married = (Marital_status == "Married")
regress Wage Married

gen Male = (Gender == "Male")
regress Wage Male

gen Married_Male = Married * Male
regress Wage Married Male Married_Male
regress Wage Married##Male

margins Male#Married 
