*------------*
*   Lab 4    *
*   Review   *
*   9.24.21  *
*------------*

* open a log
log using "C:\Users\Rhiannon\Google Drive\Hopkins\ISS F21\Lab4\lab4results.txt"


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

* do sum and tab of them by sex
sum DEGREE EDUC if SEX == 1
sum DEGREE EDUC if SEX == 2
bysort SEX: sum DEGREE EDUC

tab DEGREE if SEX == 1
tab DEGREE if SEX == 2

tab EDUC if SEX == 1
tab EDUC if SEX == 2

bysort SEX: tab DEGREE
bysort SEX: tab EDUC

* create a new variable called hgc based on educ that recodes missing values to .

gen hgc = EDUC
recode hgc 97/99 = .

*** Presenting data with graphs ***

*** Pie chart
* Note 
*over() specifies the variable over which the graph is made
* plabel() labels the pie slices in the graph 
* color specifies the color of the label in the pie slice
tab DEGREE, nolab
graph pie DEGREE, over(DEGREE) plabel(_all percent, color(white))

*** Bar chart
tab hgc 
tab hgc, nolab

*Note:
*over () specifies the variable over which the graph is made
* ytitle() specifies the title of the x-axis

graph bar, over(hgc) ytitle(Percent)
graph bar if EDUC !=98 & EDUC !=99, over(EDUC) ytitle(Percent)

*** Histogram 
* Note:
* frequency bin sets the number of bins or categories in the histogram
* scale sets the scale (from and to) for the x-axis
* xlabel sets HOW the x-axis is labeled (start(increment)end)
* So this x-axis runs from 10 to 60 and is labeled at increments of 10 bewteen 10 and 60
tab AGEKDBRN
hist AGEKDBRN if AGEKDBRN>=12 & AGEKDBRN <=51, frequency bin(51) xscale(r(10 60)) xlabel(10(10)60)

