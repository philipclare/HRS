
/**********************************************/
/* Syntax File 1                              */
/* Data cleaning                              */
/**********************************************/

import spss using "C:/Users/pjclare/Dropbox (Sydney Uni)/HRS/Data/2018 HRS Dataset 2018 Recoded - Restructured.sav", clear

rename *, lower

drop interviewenddate interviewmidpointdate

drop if interviewstatus==0 | interviewstatus==5 | interviewstatus==6 | interviewstatus==7
drop interviewstatus

format interviewbegindate %td

gen retiredate=mdy(monthretired,15,yearretired)
format retiredate %td
gen yearsretired=(interviewbegindate-retiredate)/365.25 if retiredate<interviewbegindate

//gen haveretireddate=yearsretired!=.
//tab laborforcestatus haveretireddate 

drop interviewbegindate retiredate yearretired monthretired proxy

replace yearsretired=. if laborforcestatus==1 | laborforcestatus==2 | laborforcestatus==3 | laborforcestatus==6

drop if birthyear==.

sort id wave
bysort id: gen n=_n
replace n=. if n!=1
replace n=wave if n==1
reshape wide education religion singleitemlonely scalelonely maritalstatus lengthcurrentmarriage selfreporthealth selfreporthealthchange depressed peopleinhousehold childrenalive laborforcestatus yearsretired n, i(id) j(wave)
reshape long
xtset id wave
forvalues i=2/13 {
	replace n=l1.n if n==. & l1.n!=.
}

drop if n==.
drop n

misstable summ *, all
misstable patt id cohort gender birthplace hispanic race birthyear education religion wave singleitemlonely maritalstatus selfreporthealth selfreporthealthchange depressed peopleinhousehold childrenalive laborforcestatus

save "C:/Users/pjclare/Dropbox (Sydney Uni)/HRS/Data/HRS Data Clean 20210611.dta", replace
