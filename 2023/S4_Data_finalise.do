
/**********************************************/
/* Syntax File 4                              */
/* Data finalise                              */
/**********************************************/

use "/Users/pjclare/Dropbox (Sydney Uni)/HRS/Data/HRS Imputed data/imputed-mice-combined.dta", clear

replace birthyear=birthyear+1890

label define gender 1 "Male" 2 "Female", modify
label values gender gender

label define ny 0 "No" 1 "Yes"
label values hispanic singleitemlonely depressed ny
label define laborforcestatus 1 "Works FT" 2 "Works PT" 3 "Unemployed" 4 "Partly retired" 5 "Retired" 6 "Disabled" 7 "Not in LbrF" 
label values laborforcestatus laborforcestatus
label define birthplace 1 "New England" 2 "Mid Atlantic" 3 "EN Central" 4 "WN Central" 5 "S Atlantic" 6 "ES Central" 7 "WS Central" 8 "Mountain" 9 "Pacific" 10 "US/NA Division" 11 "Not US/inc US terr"
label values birthplace birthplace
label define race 1 "White/Caucasian" 2 "Black/African American" 3 "Other"
label values race race
label define education 1 "Lt High-school" 2 "GED" 3 "High-school graduate" 4 "Some college" 5 "College and above"
label values education education
label define maritalstatus 1 "Married" 2 "Married,spouse absent" 3 "Partnered" 4 "Separated" 5 "Divorced" 6 "Separated/divorced" 7 "Widowed" 8 "Never married"
label values maritalstatus maritalstatus
label define religion 1 "Protestant" 2 "Catholic" 3 "Jewish" 4 "None/no pref" 5 "Other"
label values religion religion

gen employ=0 if laborforcestatus==1 | laborforcestatus==2 | laborforcestatus==4
replace employ=1 if laborforcestatus==5
replace employ=2 if laborforcestatus==3 | laborforcestatus==7
label define empl 0 "Working" 1 "Retired" 2 "Unemployed"
label var employ "Employment status"
label values employ empl

gen marital=0 if maritalstatus==1 | maritalstatus==2 | maritalstatus==3
replace marital=1 if maritalstatus==4 | maritalstatus==5 | maritalstatus==6 | maritalstatus==8
replace marital=2 if maritalstatus==7
label define mari 0 "Married/partnered" 1 "Not partnered/previously partnered" 2 "Widowed"
label var marital "Marital status"
label values marital mari

gen i_religion=0 if religion==1 | religion==2 | religion==3 | religion==5
replace i_religion=1 if religion==4
label define reli 0 "Religious" 1 "Not religious"
label var i_religion "Religious"
label values i_religion reli

gen i_birthplace=0 if birthplace>=1 & birthplace<=10
replace i_birthplace=1 if birthplace==11
label define brn 0 "Born in US" 1 "Not born in US"
label var i_birthplace "Born in US"
label values i_birthplace brn

gen ethnicity=0 if race==1 & hispanic==0
replace ethnicity=1 if race==2 & hispanic==0
replace ethnicity=2 if hispanic==1
replace ethnicity=3 if race==3 & hispanic==0
label define eth 0 "White/caucasian" 1 "Black/African American" 2 "Hispanic" 3 "Other"
label var ethnicity "Race/ethnicity"
label values ethnicity eth

gen caucasian=ethnicity>0
label define cauc 0 "White/caucasian" 1 "Not white/caucasian"
label var caucasian "Race/ethnicity - caucasian"
label values caucasian cauc

replace education=3 if education==2
label define education 3 "High school graduate/GED", modify

gen i_livealone=0 if peopleinhousehold>1 & peopleinhousehold!=.
replace i_livealone=1 if peopleinhousehold==1
label var i_livealone "Lives alone"
label values i_livealone ny

gen i_livingchildren=childrenalive>0
label var i_livingchildren "Have living children"
label values i_livingchildren ny

drop cohort

gen cohort=0 if birthyear<=1900
replace cohort=1 if birthyear>1900 & birthyear<=1927
replace cohort=2 if birthyear>1927 & birthyear<=1945
replace cohort=3 if birthyear>1945 & birthyear<=1964
label define coh 0 "Lost generation (1883-1900)" 1 "G.I. generation (1901-27)" 2 "Silent generation (1928-45)" 3 "Baby boomers (1946-64)"
label values cohort coh
label var cohort "Generational cohort"

replace scalelonely=. if wave<7
replace lengthcurrentmarriage=. if maritalstatus!=1 & maritalstatus!=2 & maritalstatus!=3 & maritalstatus!=4 & maritalstatus!=6
replace lengthcurrentmarriage=0 if lengthcurrentmarriage<0
replace yearsretired=. if laborforcestatus!=4 & laborforcestatus!=5
replace yearsretired=0 if yearsretired<0

drop if cohort==.

merge m:1 id wave using "/Users/pjclare/Dropbox (Sydney Uni)/HRS/Data/Death.dta", keep(match master) nogen
drop if status>=5

egen newid = group(imp id)
xtset newid wave
gen suslonely=f1.singleitemlonely + f2.singleitemlonely + f3.singleitemlonely
recode suslonely 1=0 2=0 3=1
gen f1lonely=f1.singleitemlonely
gen scalelonely_ind=0 if scalelonely<6
replace scalelonely_ind=1 if scalelonely>=6 & scalelonely!=.
gen f1scalelonely=f1.scalelonely
gen f1scalelonely_ind=f1.scalelonely_ind
label values suslonely f1lonely scalelonely_ind f1scalelonely_ind ny
xtset, clear
drop newid

mi import flong, m(imp) id(id wave) imputed(scalelonely yearsretired lengthcurrentmarriage selfreporthealthchange singleitemlonely depressed childrenalive laborforcestatus maritalstatus selfreporthealth peopleinhousehold religion race birthplace hispanic education cohort gender birthyear suslonely employ marital i_religion i_birthplace ethnicity f1lonely f1scalelonely f1scalelonely_ind) clear

save "/Users/pjclare/Dropbox (Sydney Uni)/HRS/Data/HRS Imputed data/final imputed data.dta", replace
