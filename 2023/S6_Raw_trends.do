log using "/Users/pjclare/Dropbox (Sydney Uni)/HRS/Results/raw trends.smcl", replace

/**********************************************/
/* Syntax File 6                              */
/* Analysis of raw trends                     */
/**********************************************/

use "/Users/pjclare/Dropbox (Sydney Uni)/HRS/Data/HRS Imputed data/final imputed data.dta", clear

/* Sustained loneliness trends                */
mi estimate, esampvaryok: mean suslonely if wave>=2 & cohort>0 & laborforcestatus!=6, over(wave)
mi estimate, esampvaryok: mean suslonely if wave>=2 & cohort>0 & laborforcestatus!=6, over(wave gender)
mi estimate, esampvaryok: mean suslonely if wave>=2 & cohort>0 & laborforcestatus!=6, over(wave ethnicity)
mi estimate, esampvaryok: mean suslonely if wave>=2 & cohort>0 & laborforcestatus!=6, over(wave caucasian)
mi estimate, esampvaryok: mean suslonely if wave>=2 & cohort>0 & laborforcestatus!=6, over(wave cohort)
mi estimate, esampvaryok: mean suslonely if wave>=2 & cohort>0 & laborforcestatus!=6, over(wave education)
mi estimate, esampvaryok: mean suslonely if wave>=2 & cohort>0 & laborforcestatus!=6, over(wave employ)
mi estimate, esampvaryok: mean suslonely if wave>=2 & cohort>0 & laborforcestatus!=6, over(wave marital)

/* Point loneliness trends                    */
mi estimate, esampvaryok: mean f1lonely if wave>=2 & cohort>0 & laborforcestatus!=6, over(wave)
mi estimate, esampvaryok: mean f1lonely if wave>=2 & cohort>0 & laborforcestatus!=6, over(wave gender)
mi estimate, esampvaryok: mean f1lonely if wave>=2 & cohort>0 & laborforcestatus!=6, over(wave ethnicity)
mi estimate, esampvaryok: mean f1lonely if wave>=2 & cohort>0 & laborforcestatus!=6, over(wave caucasian)
mi estimate, esampvaryok: mean f1lonely if wave>=2 & cohort>0 & laborforcestatus!=6, over(wave cohort)
mi estimate, esampvaryok: mean f1lonely if wave>=2 & cohort>0 & laborforcestatus!=6, over(wave education)
mi estimate, esampvaryok: mean f1lonely if wave>=2 & cohort>0 & laborforcestatus!=6, over(wave employ)
mi estimate, esampvaryok: mean f1lonely if wave>=2 & cohort>0 & laborforcestatus!=6, over(wave marital)

/* Scale indicator trends                   */
mi estimate, esampvaryok: mean f1scalelonely_ind if wave>=2 & cohort>0 & laborforcestatus!=6, over(wave)
mi estimate, esampvaryok: mean f1scalelonely_ind if wave>=2 & cohort>0 & laborforcestatus!=6, over(wave gender)
mi estimate, esampvaryok: mean f1scalelonely_ind if wave>=2 & cohort>0 & laborforcestatus!=6, over(wave ethnicity)
mi estimate, esampvaryok: mean f1scalelonely_ind if wave>=2 & cohort>0 & laborforcestatus!=6, over(wave caucasian)
mi estimate, esampvaryok: mean f1scalelonely_ind if wave>=2 & cohort>0 & laborforcestatus!=6, over(wave cohort)
mi estimate, esampvaryok: mean f1scalelonely_ind if wave>=2 & cohort>0 & laborforcestatus!=6, over(wave education)
mi estimate, esampvaryok: mean f1scalelonely_ind if wave>=2 & cohort>0 & laborforcestatus!=6, over(wave employ)
mi estimate, esampvaryok: mean f1scalelonely_ind if wave>=2 & cohort>0 & laborforcestatus!=6, over(wave marital)

log close
