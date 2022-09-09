**************
**************
*   Lab 5    *
*   Review   *
*   9.24.21  *
**************
**************

*** set-up

clear all  
set more off 
set linesize 100 

* open a log
log using "C:\Users\Rhiannon\Google Drive\Hopkins\ISS F21\lab5.txt", replace


* find your current working direcctory
cd

* set your working directory
cd "C:\Users\Rhiannon\Google Drive\Hopkins\ISS F21\Lab4"

* read in gss-a
use "gss18ssds-a.dta", clear

* find all variables related to education
lookfor education
lookfor educ 

* describe degree and edu
d DEGREE EDUC
describe DEGREE EDUC

* do sum and tab of them
sum DEGREE EDUC
tab DEGREE
tab EDUC
tab EDUC DEGREE

tab DEGREE EDUC, row col

* create a new variable called hgc based on educ that recodes missing values to .

gen hgc = EDUC
recode hgc 97/99 = .
tab EDUC hgc

gen college = DEGREE
recode college 0/3 = 0 4/5 = 1 97/99 = .
tab DEGREE college

* fancy way to create binary variables from a categorical variable
* the gen() option after tab creates a dummy variable for each category of DEGREE
tab DEGREE, gen(deg)
lookfor deg
* then you have to rename them
rename deg1 lths
rename deg2 hs
rename deg3 scol
rename deg4 ba
rename deg5 grad

* always, always, always check your work
tab DEGREE lths
tab DEGREE hs
tab DEGREE scol
tab DEGREE ba
tab DEGREE grad

*** calculating confidence intervals using Stata

help ci

* syntax
* ci statistic varlist if condition, options
* NOTE: option level() allows you to specify the confidence intervals
* Stata's default is ,level(95)

* examples

ci mean hgc
ci mean hgc if SEX == 1
ci mean hgc, level(99)

ci proportion college
ci proportion lths hs scol ba grad, level(90)

* using bysort
bysort SEX: ci proportion college

*** Your turn

* 1. select one interval-ratio variable and one ordinal or nominal variable
* 2. create new versions of the variables and recode any missings
* 3. turn the nominal/ordinal variable into dummies or a single binary variable
* 4. calculate the confidence intervals for them

log close








