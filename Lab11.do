*****************
*****************
*   Lab 10      *
*               *  
* multivariate  *
* regression    *  
*               *
*   11.19.21    *
*****************
*****************

*** set-up

clear all  
set more off 
set linesize 100 
capture log close

* open a log
log using "C:\Users\rhian\My Drive\Hopkins\ISS F21\lab11.txt", text replace


* find your current working direcctory
cd

* set your working directory
cd "C:\Users\rhian\My Drive\Hopkins\ISS F21"

* read in gss-a
use "gss18ssds-b.dta", clear

*** Mini-investigation of HRSRELAX ***

* find hours per day that respondents relax

lookfor relax
tab HRSRELAX
tab HRSRELAX, nolabel
sum HRSRELAX if HRSRELAX < 0 | HRSRELAX > 24
*note: why did I set this greater than 24? Because the question is
*asking how much respondents relax in a given day, which means they
*can't relax more than 24 hours in a day

* find independent variables of interest
* what other characteristics might affect how much time someone spends relaxing?

d /* will show all variables with labels in dataset */

* I'm looking for variables related to having education, having kids, working and income
lookfor educ
lookfor child
lookfor kid
lookfor work
lookfor inc

tab EDUC
sum INCOME16
sum RINCOM16
tab SEX
tab ADULTS
tab HOMPOP
tab AGE
tab CLASS

* clean data
* note: in the interest of time I did not add variable and value labels but you should when you are cleaning your data

* hrsrelax

gen relax = HRSRELAX
replace relax = . if HRSRELAX < 0 | HRSRELAX > 24
sum relax if relax < 0 | relax > 24

* R's education
tab EDUC
tab EDUC, nolabel

gen reduc = EDUC
recode reduc 97/99 = .
tab reduc

* HH income
sum INCOME16
tab INCOME16

sum RINCOM16
tab RINCOM16

gen hhinc_10000 = RINCOM16/10000

* sex
tab SEX
tab SEX, nolabel

gen female = SEX
recode female 1=0 2=1
tab female SEX

* kids in hh
gen numkids = HOMPOP - ADULTS
tab numkids

*note: create a binary 0/1 variable using a logic statement
gen kidspres = (numkids > 0)
tab numkids kidspres

* it's a little too complicated to do crosstabs to check the variable creation I just did
* so, I use list here to check example cases instead to make sure I coded my variables correctly
list HOMPOP ADULTS numkids kidspres if _n < 16

* age
tab AGE
tab AGE, nolabel

gen ageC = AGE
recode ageC 99 = .
tab ageC

* class
tab CLASS
tab CLASS, nolabel

gen classr = CLASS
recode classr 8/9 = .
tab classr, gen(classr)
lookfor class
rename classr1 lwr_class
rename classr2 wkg_class
rename classr3 mid_class
rename classr4 upr_class

tab CLASS lwr_class
tab CLASS wkg_class
tab CLASS mid_class
tab CLASS upr_class

*** analysis

* anova

oneway relax classr, tab
* note: life would be much easier and cleaner if my created variable had a value label
* lazy way of doing it for today
oneway relax CLASS if classr != ., tab

* scatter plot with fitted line

scatter relax reduc || lfit relax reduc

* bivariate regression
reg relax reduc

* correlations
corr relax reduc hhinc_10000 ageC

*note, for homeworks, use corr
pwcorr relax reduc hhinc_10000 ageC

*multivariate regression
reg relax reduc hhinc_10000 ageC

reg relax reduc hhinc_10000 ageC female

reg relax reduc hhinc_10000 ageC female wkg_class mid_class upr_class numkids kidspres
*note: do not use two versions of the same variable in your model

reg relax reduc hhinc_10000 ageC female wkg_class mid_class upr_class numkids

reg relax reduc hhinc_10000 ageC female wkg_class mid_class upr_class kidspres

log close
