**************
**************
*   Lab 6    *
*   ttests   *
*   10.08.21 *
**************
**************

*** set-up

clear all  
set more off 
set linesize 100 

* open a log
log using "C:\Users\Rhiannon\Google Drive\Hopkins\ISS F21\lab6.txt", replace


* find your current working direcctory
cd

* set your working directory
cd "C:\Users\Rhiannon\Google Drive\Hopkins\ISS F21\"

* read in gss-a
use "GSS\gss18ssds-a.dta", clear

* prepare data

* create a new variables called hgc based on educ for respondent, respondent's mother, and spouse that recodes missing values to .

gen hgc = EDUC
recode hgc 97/99 = .
tab EDUC hgc, miss

gen mahgc = MAEDUC
recode mahgc 97/99 = .
tab MAEDUC mahgc, miss

gen cohgc = COEDUC
recode cohgc 97/99 = .
tab COEDUC cohgc, miss

* create a binary variable that is = 1 if the respondent has a college degree and = 0 if they do not

gen baplus = DEGREE
recode baplus 0/3 = 0 4/5 = 1 97/99 = .
tab DEGREE baplus, miss

*** ttests using stata

help ttest

**syntax for one-sample
* ttest varname == numeric value if condition, options
* for a one sample test, you're just comparing it to a single value

* examples

ttest hgc == 13

ttest mahgc == 13

ttest mahgc == 11.8

/* notes for output (borrowed from UCLA IDRE website)

Pr(T < t), Pr(T > t) (the far left and far right reported p-values)
These are the one-tailed p-values evaluating the null against the alternatives that the mean is less than the specified value (left test) and greater than the specified value (right test). If the p-value is less than the pre-specified alpha level (usually .05 or .01) we will conclude that mean is statistically significantly greater or less than the null hypothetical value. 

Pr(|T| > |t|) – This is the two-tailed p-value evaluating the null against an alternative that the mean is not equal to the specified value.  It is equal to the probability of observing a greater absolute value of t under the null hypothesis.  If p-value is less than the pre-specified alpha level (usually .05 or .01, here the former) we will conclude that mean is statistically significantly different from zero.  For example, the p-value for hgc is smaller than 0.05. So we conclude that the mean for hgc is different from 13. */

**syntax for independent sample
* ttest varname, by(comparison variable)
* for an independent sample test, you are comparing the means from two different groups

ttest mahgc, by(baplus)
ttest mahgc, by(SEX)

/* Notes on output

Pr(|T| > |t|) – This is the two-tailed p-value computed using the t distribution.  If p-value is less than the pre-specified alpha level (usually .05 or .01, here the former) we will conclude that the difference in means is statistically significantly different from zero. For example, the p-value for the difference between those with a BA and those without is less than 0.05, so these two means are significantly different from each other.

Pr(T < t), Pr(T > t) – These are the one-tailed p-values for the alternative hypotheses (difference < 0) and (difference > 0), respectively.  As usual, if p-value is less than the pre-specified alpha level (usually .05 or .01) we will conclude that the difference in the means is statistically significantly greater or less than zero. */

**syntax for paired test
* ttest varname1 == varname2
* use this when the observations are not independent of each other
* this is used for comparing two DIFFERENT variables

ttest hgc == mahgc
ttest hgc == cohgc

/* notes on output

Pr(|T| > |t|)– This is the two-tailed p-value computed using the t distribution.  If the p-value is less than the pre-specified alpha level (usually .05 or .01, here the former) we will conclude that mean difference between the two variables is statistically significantly different from zero.  For example, the p-value for the difference between respondent's highest grade completed and mother's highest grade completed is less than 0.05 so we conclude that the mean of the two variables is significantly different from each other.

k. Pr(T < t), Pr(T > t)- These are the one-tailed p-values for evaluating the alternatives (mean < H0 value) and (mean > H0 value), respectively.  Like Pr(|T| > |t|), they are computed using the t distribution. Again, if the p-value is less than the pre-specified alpha level (usually .05 or .01) we will conclude that the difference in the two means is statistically significantly greater than or less than zero.



*** Your turn

* 1. select two interval ratio variables
* 2. create new versions of the variables and recode any missings
* 3. run one sample ttests on them
* 4. run a ttest comparing their values to each other
* 4. choose one variable and run a ttest comparing their means by SEX

log close








