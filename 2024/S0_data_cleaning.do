
import spss using "D:/Dropbox (Sydney Uni)/HRS/Paper 2 - Bidirectional analysis/Data/HRS 2018 - New Variables - Weighted_Restructured 21062022.sav", clear

drop Weight
rename ID id
rename SingleItemLonely lonely
rename LaborForceStatus labourforce
rename ChildrenAlive livingchildren
rename *, lower

drop if birthyear==.

gen vigpa_bin=0 if vigpa>=3 & vigpa!=.
replace vigpa_bin=1 if vigpa<=2

gen modpa_bin=0 if modpa>=3 & modpa!=.
replace modpa_bin=1 if modpa<=2

gen sclonely=0 if scalelonely<6
replace sclonely=1 if scalelonely>=6 & scalelonely!=.

xtset id wave

gen sclasked=0 if sclonely!=. & wave==6
forvalues i=7(2)13 {
	local j=`i'-6
	replace sclasked=1 if f`j'.sclonely!=. & sclasked==. & wave==6
}
forvalues i=8(2)14 {
	local j=`i'-6
	replace sclasked=0 if f`j'.sclonely!=. & sclasked==. & wave==6
}
replace sclasked=l1.sclasked if sclasked==. & l1.sclasked!=.
label define eo 0 "Even" 1 "Odd"
label values sclasked eo

replace gender=gender-1
label define gender 0 "Male" 1 "Female", modify
label values gender gender

gen b_depressed=depressed if wave==1
replace depressed=. if wave==1
label values b_depressed labels13

label define ny 0 "No" 1 "Yes"
label values hispanic lonely depressed ny

label define labourforce 1 "Works FT" 2 "Works PT" 3 "Unemployed" 4 "Partly retired" 5 "Retired" 6 "Disabled" 7 "Not in LbrF" 
label values labourforce labourforce
label define birthplace 1 "New England" 2 "Mid Atlantic" 3 "EN Central" 4 "WN Central" 5 "S Atlantic" 6 "ES Central" 7 "WS Central" 8 "Mountain" 9 "Pacific" 10 "US/NA Division" 11 "Not US/inc US terr"
label values birthplace birthplace
label define race 1 "White/Caucasian" 2 "Black/African American" 3 "Other"
label values race race
label define education 1 "Lt High-school" 2 "GED" 3 "High-school graduate" 4 "Some college" 5 "College and above"
label values education education
label define marital 1 "Married" 2 "Married,spouse absent" 3 "Partnered" 4 "Separated" 5 "Divorced" 6 "Separated/divorced" 7 "Widowed" 8 "Never married"
label values marital marital
label define religion 1 "Protestant" 2 "Catholic" 3 "Jewish" 4 "None/no pref" 5 "Other"
label values religion religion

gen employ=0 if labourforce==1 | labourforce==2 | labourforce==4
replace employ=1 if labourforce==5
replace employ=2 if labourforce==3 | labourforce==7
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

gen i_livingchildren=livingchildren>0
label var i_livingchildren "Have living children"
label values i_livingchildren ny

su bmi
replace bmi=(bmi-r(mean))/r(sd)

drop cohort

gen cohort=0 if birthyear<=1900
replace cohort=1 if birthyear>1900 & birthyear<=1927
replace cohort=2 if birthyear>1927 & birthyear<=1945
replace cohort=3 if birthyear>1945 & birthyear<=1964
label define coh 0 "Lost generation (1883-1900)" 1 "G.I. generation (1901-27)" 2 "Silent generation (1928-45)" 3 "Baby boomers (1946-64)"
label values cohort coh
label var cohort "Generational cohort"

xtset id wave
forvalues j=2/14 {
	local k=`j'-1
	foreach i in highbp cancer lungdisease heartprobs stroke psychprobs arthritis {
		replace `i'_ever=l`k'.`i'_ever if ((`i'_ever==. & l`k'.`i'_ever!=.) | (`i'_ever==0 & l`k'.`i'_ever==1)) & wave==`j'
		replace `i'_ever=1 if `i'_ever==0 & (`i'_wave==1 | `i'_wave==3)
	}
}

egen sumconditions=rowtotal(highbp_wave cancer_wave lungdisease_wave heartprobs_wave stroke_wave psychprobs_wave arthritis_wave)
egen sctest=rownonmiss(highbp_wave cancer_wave lungdisease_wave heartprobs_wave stroke_wave psychprobs_wave arthritis_wave)
replace sumconditions=sumconditions/sctest*7
drop sctest

rename cesdnodepression cesd_nodep
rename _v1 cesd_nodeplon

merge m:1 id wave using "D:/Dropbox (Sydney Uni)/HRS/Paper 2 - Bidirectional analysis/Data/Weights.dta", keep(match master) nogen

keep id wave interviewstatus secu strata wgt1 wgt2 wgt3 wgt4 ///
cesd cesd_nodep cesd_nodeplon bmi adl3 adl5 depressed gender employ marital ethnicity education cohort ///
highbp_ever cancer_ever lungdisease_ever heartprobs_ever stroke_ever psychprobs_ever arthritis_ever ///
i_religion i_birthplace i_livealone i_livingchildren ///
lonely vigpa_bin modpa_bin

order id wave interviewstatus secu strata wgt1 wgt2 wgt3 wgt4 ///
cesd cesd_nodep cesd_nodeplon bmi adl3 adl5 depressed gender employ marital ethnicity education cohort ///
highbp_ever cancer_ever lungdisease_ever heartprobs_ever stroke_ever psychprobs_ever arthritis_ever ///
i_religion i_birthplace i_livealone i_livingchildren ///
lonely vigpa_bin modpa_bin

rename i_* *

gen test_adl=adl5>adl3 & adl5!=. & adl3!=.
bysort id: egen maxadl=max(test_adl)

gen test_dead=1 if interviewstatus==5 | interviewstatus==6
bysort id: egen maxdead=max(test_dead)

drop if maxadl==1 | maxdead==1
drop test_adl maxadl test_dead maxdead

drop if wave<6
replace wave=wave-6
label define wv 0 "Wave 6" 1 "Wave 7" 2 "Wave 8" 3 "Wave 9" 4 "Wave 10" 5 "Wave 11" 6 "Wave 12" 7 "Wave 13" 8 "Wave 14"
label values wave wv

drop if secu==.

save "D:/Dropbox (Sydney Uni)/HRS/Paper 2 - Bidirectional analysis/Data/Clean data 20220711.dta", replace

keep id wave secu strata wgt4 ///
lonely vigpa_bin modpa_bin ///
cesd_nodeplon bmi depressed gender employ marital ethnicity education cohort ///
religion birthplace livealone livingchildren ///
highbp_ever cancer_ever lungdisease_ever heartprobs_ever ///
stroke_ever psychprobs_ever arthritis_ever

reshape wide lonely vigpa_bin modpa_bin wgt4 cesd_nodeplon bmi depressed ///
employ marital livealone livingchildren ///
highbp_ever cancer_ever lungdisease_ever heartprobs_ever ///
stroke_ever psychprobs_ever arthritis_ever, i(id) j(wave)

drop if gender==. | ethnicity==. | education==. | religion==. | birthplace==.

egen wgt4=rowmean(wgt40 wgt41 wgt42 wgt43 wgt44 wgt45 wgt46 wgt47 wgt48)
order wgt4, after(id)
order strata, after(id)
order secu, after(id)
drop wgt40 wgt41 wgt42 wgt43 wgt44 wgt45 wgt46 wgt47 wgt48

reshape long lonely vigpa_bin modpa_bin cesd_nodeplon bmi depressed ///
employ marital livealone livingchildren ///
highbp_ever cancer_ever lungdisease_ever heartprobs_ever ///
stroke_ever psychprobs_ever arthritis_ever, i(id) j(wave)

order secu strata, after(id)
order gender ethnicity education religion birthplace, after(wave)

save "D:/Dropbox (Sydney Uni)/HRS/Paper 2 - Bidirectional analysis/Data/Clean for imputation 20220711.dta", replace