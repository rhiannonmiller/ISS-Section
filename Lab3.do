**************************************
***** Intro to Social Statistics *****
***** Section 1                  *****
***** September 17, 2021         *****
***** Lab #3                     *****
**************************************

* session pre-amble 
clear all  
macro drop _all 
set more off 
set linesize 100 

* find out what your current working directory is
cd

* if you don't know how to find your working directory with Citrix, you can use
* the point and click menu to open a data file and find out where it opens from

* set your working directory
cd "C:\Users\Rhiannon\Google Drive\Hopkins\ISS F21"

* open a log
* note: using the option "replace", will reopen and rewrite your log everytime
* you run your do file
log using "Lab3.txt", text replace
* note: you can also explicitly write your log to a different folder using a file path 
* For example: log using "C:\Users\Rhiannon\Google Drive\Hopkins\ISS F21\Lab3\Lab3.txt", text replace

use "gss18ssds-a.dta", clear

*** Using variable and value labels ***

* need to find a variable about marriage, but don't remember what it's called
lookfor marriage

* what does this variable look like and what are its values?
tab HAPMAR
tab HAPMAR, nolabel miss

* always, always, always preserve your existing data
gen hapmar01 = HAPMAR
recode hapmar01 0 8 9=. 1/2 = 1 3 = 0
* note that recode always prints the number of changes made
* recode is also more explicit than replace

* always check a new variable after you have created it
tab HAPMAR hapmar01
tab HAPMAR hapmar01, miss nolabel

* now I want to label hapmar01, so I know what 1 stands for

tab hapmar01

label variable hapmar01 "happy vs. not happy"

tab hapmar01

* but now I actually want to label the values too

label define hapmar01_label 0 "not happy" 1 "happy" 

* label define just creates the LABELS for the values, now we have to attach it
* to the variable

label values hapmar01 hapmar01_label

tab hapmar01

* but what if I wanted to just use a yes no label? 
* And maybe that's applicable to other variables

* create has ba or note
tab DEGREE
tab DEGREE, nolabel miss

gen college = 0
replace college = 1 if DEGREE > 2

tab DEGREE college

* let's make female a variable too

tab SEX
tab SEX, nolabel miss

gen female = SEX
recode female 1=0 2=1

tab SEX female

* creating "yes/no" label

label define l_yesno 0 "no" 1 "yes" 

label values hapmar01 college female l_yesno

tab hapmar01
tab college
tab female

*** Compare means for different groups ***

*** Example: Men vs. Women 
tab SEX
tab SEX, nolabel

** On average, between men and women, which sex has more years of schooling? 

sum EDUC if female == 1
sum EDUC if female == 0

* but wait, the max values aren't right

tab EDUC
tab EDUC, miss nolabel

gen hgc = EDUC
recode hgc 97/99 = .

* bysort is a prefix command that repeats the following command for each group specified
bys female: sum hgc

* what about degree?
tab DEGREE
tab DEGREE, nolabel

* bysort works with many different commands
bys female: tab DEGREE

* note this looks the same as using bysort
tab DEGREE if female == 0
tab DEGREE if female == 1

* you can get some of the same information by doing a cross tab with row and col options
* but it might be easier to read with bysort
tab SEX DEGREE, row col

* note: I'm closing my log here so that it will save
log close 
* sometimes when you try to open a log, but you already have one open, you need 
* to use this command to explicitly close any open logs

