*****************
*Research SIA
******************
*Ethiopia 2016 DHS data:
cd "C:\Users\carla\Desktop\Research SIA\Session7"
use "ETKR70FL"

* weight variable:
generate wgt = v005/1000000

*create strata variable:
egen strata=group(v024 v025),label
tab strata

*PSU variable is v021
svyset v021 [pweight=wgt], strata(strata)

*make variable for height-for-age- z-score:
gen haz=hw70
tab haz, m
replace haz=. if haz==9996|haz==9997|haz==9998|haz==9999
replace haz=haz/100

*Rename sex variable:
rename b4 female

*Create birth order variable:
*Categorical variable for birth order:
gen birth_order=.
replace birth_order=1 if bord==1
replace birth_order=2 if bord==2
replace birth_order=3 if bord==3
replace birth_order=4 if bord>=4&bord<.

*Rename age variable:
rename hw1 age_months

*Mom education:
gen mom_anyeduc=.
replace mom_anyeduc=1 if v106>0&v106<4
replace mom_anyeduc=0 if v106==0

*Summary statistics:
mean haz female age_months i.birth_order mom_anyeduc
svy: mean haz female age_months i.birth_order mom_anyeduc
estat sd

*Regression:
regress haz mom_anyeduc female age_months i.birth_order
svy: regress haz mom_anyeduc female age_months i.birth_order

*gen sub-pop for kids 12 months and older:
gen oneplus=.
replace oneplus=0 if age_months<12
replace oneplus=1 if age_months>=12&age_months<.

svy, subpop(oneplus): regress haz mom_anyeduc female age_months i.birth_order

*Using the margins command with svy data and subpop:
margins,subpop(oneplus)  atmeans at(mom_anyeduc=(0 1))