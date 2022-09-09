* Lab #1 & 2
* This is text
/* this is text going beyond one 
line*/
/*This is more text
hjhkgalkjkljhasdfkjajkh*/

* Introduction to Social Statistics, Fall 2021
* 10 September 2021 

**********************
*** Intro to Stata ***
*** Using commands ***
*** Using do files ***
**********************

* Output window vs. Do-File
* Output window: 5 boxes 
* Do-file: 1 blank page 

*Initial commands to clear and manage your workspace
cls // clear the screen
version 16 // set STATA version
clear all // remove all data 
macro drop _all // remove all macros
set more off // display all of the data at once 
set linesize 100 // so that the information fits on the screen


* Use data: 
* Main window (open folder)

* update this file path with your own
use "C:\Users\Rhiannon\Google Drive\Hopkins\ISS F21\gss18ssds-a.dta", clear

* Browse data: 
* Main window (magnifying glass)
browse 
browse AGE SEX DEGREE PAPRES10 //browse a selection of dataset 

* Getting to know your data 
summarize
describe

**Describes the dataset or a particular variable
describe SEX
desc /*var1*/
desc SIBS

* Summarize data: # of observations, mean, std dev, min, max
summarize 
sum 
sum PAPRES10 
sum PAPRES10, d
sum PAPRES10 SEX DEGREE INCOME16

* Tabulate data: frequency and columnn percentage
tabulate 

tab SEX, missing  
tab SEX, miss
tab DEGREE, miss
tab DEGREE, miss nolabel

tab MADEG PADEG, miss
tab MADEG PADEG, miss nolabel
tab2 MARITAL DEGREE SEX //tabulate 3+ variables 

*** NEW VARIABLE FROM EXISTING VARIABLE ***
* Method #1: Generate a new variable 
tab DEGREE
tab DEGREE, nolabel 

gen college=0 //whether or not respondent is college educated
replace college=1 if DEGREE>2
tab college, miss

tab college DEGREE

* Method #2: Recode an existing variable 
tab DEGREE 
recode DEGREE (0 1 2 = 0) (3 4= 1), gen(rdegree)

tab rdegree college

** Renaming a variable
rename rdegree respdeg

* note: Stata is cAsE SeNsItIvE
rename EDUC educ

* Eliminate a variable or particular cases from a data set
drop
drop if SEX== 1
tab SEX, miss

* Retaining only the cases or variables specified
keep /*var1 var2 var3*/
keep if AGE<21 

* Directory - where your work is saved 
cd 

* change the directory your work is automatically saved to by assigning a different file path using the cd command
*cd "C:\"

* Save dta file 
save "C:\Users\Rhiannon\Google Drive\Hopkins\ISS F21\gss-step1.dta", replace

* export the data you have in Stata to an excel file
* note: replace writes over an existing file if one alredy exists in the directory
* with the same name
export excel "C:\Users\Rhiannon\Google Drive\Hopkins\ISS F21\gss18ssds-a-working.xls", replace firstrow(variables)

* Import data from other types of files (excel, csv, etc)
* File > Import > (file type) > Browse > "OK"
*import excel "C:\Users\Rhiannon\Google Drive\Hopkins\ISS F21\gss18ssds-a-working.xls", clear 
* do you know what first row does in this case? if not, Google it
*firstrow