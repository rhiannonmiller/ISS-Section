**************
**************
*   Lab 9    *
*            *
*   anova    *
*   11.05.21 *
**************
**************

*** set-up

clear all  
set more off 
set linesize 100 
capture log close

* open a log
log using "C:\Users\rhian\My Drive\Hopkins\ISS F21\lab9.txt", text replace


* find your current working direcctory
cd

* set your working directory
cd "C:\Users\rhian\My Drive\Hopkins\ISS F21"

* read in gss-a
use "gss18ssds-a.dta", clear

* check and prepare data

tab MARITAL
sum TVHOURS

** Anova

* note the ordering of the variables matters
* command dv iv

anova TVHOURS MARITAL

oneway TVHOURS MARITAL 
oneway TVHOURS MARITAL, tab 

* note that oneway produces the same results as anova, but the ouptu is more clear
* SSB = Between groups
* SSW = Within groups
* SST = Total

** By A Third Group **
tab SEX
tab SEX, nolabel

bysort SEX: oneway TVHOURS MARITAL , tab

** Your turn

* 1. find the variable "age when kids were first born"
lookfor kid
lookfor age

* 2. Use it to create a binary variable for respondents with kids vs. not

tab AGEKDBRN
tab AGEKDBRN, nolabel

gen parental = AGEKDBRN

recode parental 12/51 = 1 98/99 = .

tab AGEKDBRN parental, miss

* 3. Run an anova on TVHOURS and your new variables

oneway TVHOURS parental

* 4. Add in marital

bysort parental: oneway TVHOURS MARITAL, tab

* Now go back and check your data

sum TVHOURS
tab TVHOURS
tab TVHOURS, nolabel

* note that we missed some values we should have recoded

gen tvhoursC = TVHOURS
recode tvhoursC -1 98/99 = .

tab tvhoursC, miss

* now let's go back and do our analysis again

oneway TVHOURS MARITAL, tab 
bysort parental: oneway TVHOURS MARITAL, tab

* Does it change our conclusions about our hypotheses?

*** YES ***

* The lesson: always check your data
* The consequences can be significant

log close
