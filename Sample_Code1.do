/*********************
Research General Social Survey
********************/

cd "C:\Users\carla\Desktop\Research SIA"
use "GSS2018.dta" 

*Confidence intervals:
tab abortion_health
ci mean abortion_health

ci mean age sei10 abortion_health, level(90)
ci mean abortion_health, level(99)

*Cross-tabulation
tab1 astrosci colsci
tab astrosci colsci

tab astrosci colsci, col

tab astrosci colsci, row
*looking at percentages without number of cases
tab astrosci colsci, col nof

bys born: tab astrosci colsci, row


tab1 sei10 cosei10
graph twoway scatter sei10 cosei10
graph twoway scatter sei10 tvhours
corr sei10 cosei10
pwcorr sei10 cosei10 tv, sig


tab xmovie
sum age
tab xmovie, sum(age)
tab goveqinc
sum sei10
tab goveqinc, sum(sei10)

tab1 boyorgrl hsbio
tab boyorgrl hsbio, col chi2
tab boyorgrl hsbio if sex==1, col chi2
tab boyorgrl hsbio if sex==2, col chi2

*t-test
tab hompop
sum hompop
ttest hompop==3

*t-test 
ttest masei10==pasei10

*t-test 
sum hompop
tab born
ttest hompop, by(born)

recode sex (1=1 "male") (2=0 "female"), gen(male)
tab male
prtest male=0.5


tab cappun
tab cappun, nola
recode cappun (1=1 "favor") (2=0 "oppose"), gen(capital_pun)
tab colrac
tab colrac, nola
recode colrac (4=1 "allowed") (5=0 "not allowed"), gen (racist_teach)
prtest capital_pun==racist_teach


prtest racist_teach, by(male)
prtest capital_pun, by(male)

*Bivariate linear regression:
tab prestg10
tab educ
regress prestg10 educ
*to look at relationship graphically:
graph twoway scatter prestg10 educ





