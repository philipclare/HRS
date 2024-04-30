log using "/Users/pjclare/Dropbox (Sydney Uni)/HRS/Results/multivariable.smcl", replace

/**********************************************/
/* Syntax File 9                              */
/* Multivariable analysis                     */
/**********************************************/

use "/Users/pjclare/Dropbox (Sydney Uni)/HRS/Data/HRS Imputed data/final imputed data.dta", clear

mi estimate, cmdok esampvaryok dots: melogit suslonely i.employ i.marital i.gender i.caucasian ib3.cohort ib5.education c.wave if cohort>0 & laborforcestatus!=6 || id:, intp(5)

mi estimate, cmdok esampvaryok dots: melogit f1lonely i.employ i.marital i.gender i.caucasian ib3.cohort ib5.education c.wave if cohort>0 & laborforcestatus!=6 || id:, intp(5)

mi estimate, cmdok esampvaryok dots: melogit f1scalelonely_ind i.employ i.marital i.gender i.caucasian ib3.cohort ib5.education c.wave if cohort>0 & laborforcestatus!=6 || id:, intp(5)

log close