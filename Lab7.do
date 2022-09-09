**************
**************
*   Lab 7    *
*   review   *
*   2x2 tab  *
*   10.15.21 *
**************
**************

*** set-up

clear all  
set more off 
set linesize 100 
capture log close

* open a do file
* open a log (that will save as a text file)
* set your working directory
* read in the gss18ssds-a dataset

* create the following variables:
* baplus where =1 if r graduated from college and 0 if they didn't
* mabaplus where =1 if r's mother graduated from college and 0 if they didn't
* pabaplus where =1 if r's father graduated from college and 0 if they didn't
* check all variables after creating them





























* open a log
log using "C:\Users\Rhiannon\Google Drive\Hopkins\ISS F21\lab7.txt", text replace


* find your current working direcctory
cd

* set your working directory
cd "C:\Users\Rhiannon\Google Drive\Hopkins\ISS F21\"

* read in gss-a
use "GSS\gss18ssds-a.dta", clear

* prepare data

* create a binary variable that is = 1 if the respondent/mother/father has a college degree and = 0 if they do not

gen baplus = DEGREE
recode baplus 0/2 = 0 3/4 = 1 97/99 = .
tab DEGREE baplus, miss

gen mabaplus = MADEG
recode mabaplus 0/2 = 0 3/4 = 1 7/99 = .
tab MADEG mabaplus, miss

gen pabaplus = PADEG
recode pabaplus 0/2 = 0 3/4 = 1 7/99 = .
tab PADEG pabaplus, miss

* bivariate tables
* two-way tables

tab baplus mabaplus
tab baplus mabaplus, row
tab baplus mabaplus, row col
tab baplus mabaplus, row col miss

* now do the same for respondents and fathers
* what patterns do you notice?
* are there any similar patterns between the two (baplus*mabaplus and baplus*pabaplus)?

tab PADEG baplus
tab PADEG baplus, row
tab PADEG baplus if PADEG < 7, row
tab PADEG baplus, row col


* three-way tables

bysort baplus: tab mabaplus pabaplus
bysort baplus: tab mabaplus pabaplus, row col

bysort baplus: tab mabaplus pabaplus if AGE < 35, row col


*** review notes from homework
* log files
* creating new versions of variables
* replace vs recode
* bysort vs if

log close








