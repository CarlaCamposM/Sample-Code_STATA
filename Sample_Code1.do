/***********************************
Reseach GSS 03/16/21
*********************************/

*Change working directory:
cd "C:\Users\carla\Desktop\Research SIA"

*Load dataset:
use "gss2008.dta"

*Examining data:
browse
browse id othlang 
lookfor religion
codebook wrkstat
describe wrkstat
describe
list id sex degree wrkstat educ
list id sex degree wrkstat educ in 1/10
list id sex degree wrkstat educ in 1/10, clean
list id sex degree wrkstat educ in 1/100, header(20) clean
list id sex degree wrkstat educ in -5/-1
sort sex
list id sex degree wrkstat educ in 1/10
sort sex id
list id sex degree wrkstat educ in 1/10
count
count if educ>12
inspect hompop

*Missing data:
tab dwelling, m
tab age, m
list id age if age==.
list id age if age>=.
list id if missing(age)
misstable summarize adults hispanic marital babies

*data visually:
tab educ
hist educ
hist educ, bin(10) 
hist educ, bin(10) fraction
tab degree
hist degree, discrete percent addlabel
graph box age
graph box age, over(race)

*Summarizing data:
tab happy
tab happy, m
tab sex happy
tab sex happy, row
tab sex happy, column
tab1 sex happy
tab happy, nolabel
sum educ
sum educ, detail
tab happy if sex==1
sum educ if sex==1
ssc install
fre marital
tabstat educ, stats(n mean median min max ran sd  p25 p75 iqr)

*Renaming data:
rename income family_income

*new variables:
tab age
gen age2=age^2
tab income

fre income
gen midincome=income>3 & income<7
tab midincome

* dummy variables from a continuous variable:
tab age, m
gen old=.
replace old=1 if age>75 & age<.
replace old=0 if age<=75
tab old, m

fre zodiac
gen gemini=1 if zodiac==3
replace gemini=0 if zodiac!=3
tab gemini, m


gen gemini2=zodiac==3
tab gemini2, m
tab gemini gemini2

*average age of people
egen aveage=mean(age)
tab aveage

gen age_dev= age-aveage
tab age_dev

egen age_f=max(age) if sex==2
egen age_m=max(age) if sex==1
tab age_f
tab age_m

*calculating the maximum age in each region of the US
tab region
egen maxage_region =max(age), by(region)
 tab maxage_region
 
*Labeling data:
tab gemini
label variable gemini "whether individual is a Gemini"
label define gem 1 "Gemini" 0 "Other zodiac sign"
label values gemini gem
tab gemini


tab satjob,m
tab satjob, nola m
*new variable with just two categories of job satisfaction:
gen job_satisfaction=.
replace job_satisfaction=1 if satjob==1|satjob==2
replace job_satisfaction=2 if satjob==3|satjob==4
label define job_satisfaction 1 "satisfied" 2 "dissatisfied"
label values job_satisfaction job_satisfaction
tab job_satisfaction, m
tab job_satisfaction


tab sex
tab sex, nola
recode sex (1=0) (2=1)
tab sex

label define male 0"male" 1 "female"
label values sex male 
tab sex

*recode variable 
tab educ
recode educ (0/8=1 "No High School")(9 10 11=2 "Some High School")(12=3 "High School")(13 14 15=4 "Some College")(16=5 "College")(17/20=6 "More than College")(.d .n=.), gen(educgrp)
tab educgrp, m
fre educgrp

*drop variables
drop age2 midincome gemini old
drop if age>=65
keep id region sex educ marital age


clear
