**************
**************
*   Lab 8    *
*            *
*   chi-sq   *
*   10.28.21 *
**************
**************

*** set-up

clear all  
set more off 
set linesize 100 
capture log close

* open a log
log using "C:\Users\rhian\My Drive\Hopkins\ISS F21\lab8.txt", text replace


* find your current working direcctory
cd

* set your working directory
cd "C:\Users\rhian\My Drive\Hopkins\ISS F21"

* read in gss-a
use "gss18ssds-a.dta", clear

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

gen spbaplus = SPEDUC
recode spbaplus 0/15 = 0 16/20 = 1 97/99 = .
tab SPEDUC spbaplus, miss

* bivariate tables
* two-way tables

* you can use the row or col options to display row and column frequencies
tab baplus mabaplus
tab baplus mabaplus, row
tab baplus mabaplus, row col
tab baplus mabaplus, row col miss
tab baplus mabaplus, col

* use an if statement before the options to limit what goes into the crosstab

tab baplus PADEG if PADEG < 7, row

* measures of association

/* all commands for measures of association can be used in the options
after your crosstabs

Syntax

chi-square: chi2
note include "expected" to also print the expected frequencies
Pr = is the p-value associated with the calculated chi-sq

Cramer's V: V

gamma: gamma

Kendall's tau-b: taub

Each of these print the related calculation right after the measure's name and
the equal sign. 

Both gamma and Kendall's tau-b print out the asymptomatic squared error (ASE). 
You do not need to worry about how to interpret this.

For more detail see the Stata documentation here: https://www.stata.com/manuals13/rtabulatetwoway.pdf

*/

* Here are two cases where the chi2 statistic is significant at the p<0.05 level
tab baplus mabaplus, expected chi2
tab spbaplus pabaplus, expected chi2

* And one where it is note* what do you see that's different in the output?
tab HAPMAR pabaplus if HAPMAR < 8, expected chi2

* adding in Cramer's V, gamma, and Kendall's tau-b to the output
tab baplus mabaplus, expected chi2 V gamma taub

* you don't have to put them as all or nothing
* you can just run say gamma and tau-b without chi2
tab baplus mabaplus,  gamma taub

* use the nofreq option to just print the measures of association and not the crosstab
tab baplus mabaplus, chi2 V gamma taub nofreq

* three-way tables

* use bysort to run a three way table
bysort baplus: tab mabaplus pabaplus

* notice it works with all of the same options, you just keep bysort var: as a prefix to all
bysort baplus: tab mabaplus pabaplus, row col

bysort baplus: tab mabaplus pabaplus if AGE < 35, row col

* and the measures of association still run in a three-way contingency table
bysort baplus: tab mabaplus pabaplus if AGE < 35, row col chi2

log close
