* Set the working directory to where your data file is located
* Replace with your actual file path
cd "C:\Users\Admin\Desktop\research-stata\session #3"

* Import the Excel data file
import excel "elemapi.xlsx", clear firstrow

* FIRST REGRESSION ANALYSIS
* Running a multiple regression on academic performance (api00) 
* and predicting it with average class size (acs_k3), percent receiving free meals (meals), and percent teachers fully credentialed (full)
regress api00 acs_k3 meals full

* Checking basic information about the data file
* This describes the data, showing number of observations and variable names
describe

* Listing the first 5 observations to get familiar with the data
list in 1/5

* Listing the first 10 observations for variables used in the regression
list api00 acs_k3 meals full in 1/10

* CODEBOOK ANALYSIS
* Inspecting detailed information about specific variables
codebook api00 acs_k3 meals full yr_rnd

* SUMMARIZING THE DATA
* Summarizing the selected variables
summarize api00 acs_k3 meals full

* Getting detailed summary statistics for acs_k3
summarize acs_k3, detail

* Checking for negative class size values with tabulate
tabulate acs_k3

* Listing schools with negative class sizes
list snum dnum acs_k3 if acs_k3 < 0

* Listing all observations from district 140, where errors were detected
list dnum snum api00 acs_k3 meals full if dnum == 140

* GRAPHICAL INSPECTION OF VARIABLES
* Creating a histogram for class size (acs_k3)
histogram acs_k3

* Boxplot for class size (acs_k3)
graph box acs_k3

* Stem-and-leaf plot for the percentage of fully credentialed teachers
stem full

* Tabulating full credentials to investigate values under 1
tabulate full

* Checking the districts with full credential proportions
tabulate dnum if full <= 1

* Counting observations in district 401
count if dnum == 401

* CORRECTING DATA
* Using the corrected data file for further analysis
import excel "elemapi2.xlsx", clear firstrow

* Repeating the original regression analysis with the corrected data
regress api00 acs_k3 meals full

* SIMPLE LINEAR REGRESSION
* Performing simple regression to examine the effect of enrollment (enroll) on academic performance (api00)
regress api00 enroll

* Predicting fitted values after regression
predict fv


* Listing the fitted values for the first 10 observations
list api00 fv in 1/10

* Scatterplot for api00 vs enroll
scatter api00 enroll

* Scatterplot with fitted regression line
twoway (scatter api00 enroll) (lfit api00 enroll)

* Adding school labels to the scatterplot for better identification
twoway (scatter api00 enroll, mlabel(snum)) (lfit api00 enroll)

* Calculating residuals after regression
predict e, residual

* MULTIPLE REGRESSION ANALYSIS
* Clearing out the data to avoid variable confusion, and loading the data again
import excel "elemapi2.xlsx", clear firstrow

* Performing a multiple regression with several predictors for api00
regress api00 ell meals yr_rnd mobility acs_k3 acs_46 full emer enroll

* Running the same regression but with standardized (beta) coefficients for easier comparison
regress api00 ell meals yr_rnd mobility acs_k3 acs_46 full emer enroll, beta

* TESTING SPECIFIC VARIABLES IN REGRESSION
* Testing if ell contributes significantly to the model
test ell

* Testing if class size (acs_k3 and acs_46) collectively contribute significantly to the model
test acs_k3 acs_46

* CHECKING CORRELATIONS BETWEEN VARIABLES
* Calculating pairwise correlations
correlate api00 ell meals yr_rnd mobility acs_k3 acs_46 full emer enroll

* Pairwise correlations with significance levels and number of observations
pwcorr api00 ell meals yr_rnd mobility acs_k3 acs_46 full emer enroll, obs sig
