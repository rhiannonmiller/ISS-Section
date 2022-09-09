**************
**************
*   Lab 10   *
*            *
* bivariate  *
* regression *  
*            *
*   11.12.21 *
**************
**************

*** set-up

clear all  
set more off 
set linesize 100 
capture log close

* open a log
log using "C:\Users\rhian\My Drive\Hopkins\ISS F21\lab10.txt", text replace


* find your current working direcctory
cd

* set your working directory
cd "C:\Users\rhian\My Drive\Hopkins\ISS F21"

* read in gss-a
use "gss18ssds-a.dta", clear

*** Introduction to Regression ***
*** Example #1

* clean data

tab EDUC
tab EDUC, nolabel

gen reduc = EDUC
recode reduc 97/99 = .
tab reduc

tab AGEKDBRN
tab AGEKDBRN, nolabel

gen age1stkid = AGEKDBRN
recode age1stkid 0 98/99 = .
tab age1stkid

* scatter plot with fitted line

scatter age1stkid reduc || lfit age1stkid reduc

scatter reduc  age1stkid || lfit reduc age1stkid

* correlations
corr age1stkid reduc
pwcorr age1stkid reduc

* covariance
corr age1stkid reduc, covariance

* bivariate regression
reg  age1stkid reduc

* Note that the SSTotal = SSModel + SSResidual.  
* SSModel / SSTotal is equal to the value of R-Square
* SSResidual is equal to SSE from the lecture slides
* SSTotal is equal to SST from the lecture slides
* SSModel is equal to SSR from the lecture slides

*** Your turn

* 1. Find and clean mother's and father's education
* 2. Create a scatter plot with a fitted line for R's education + either mother's or father'scatter
* 3. Run two bivariate regressions for mother's and father's education with R's education as the DV
* 4. Which is more consequential? Mother's or Father's education? Why?

tab MAEDUC
tab MAEDUC, nolabel

tab PAEDUC
tab PAEDUC, nolabel

gen dadeduc = PAEDUC
recode dadeduc 97/99 = .
tab dadeduc

gen momeduc = MAEDUC
recode momeduc 97/99 = .
tab momeduc

scatter reduc dadeduc || lfit reduc dadeduc

reg reduc momeduc
reg reduc dadeduc

* The r-squared is larger for dad's education, suggesting that father's education
* absorbs more of the variance in predicting respondent's education

*** preview of multivariate regression
reg reduc momeduc dadeduc

* notice how the magnitude of the coefficients change
* and how the R-squared changes compared to the bivariate versions of these regressions

log close
