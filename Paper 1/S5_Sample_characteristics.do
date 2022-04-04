log using "/Users/pjclare/Dropbox (Sydney Uni)/HRS/Results/sample characteristics.smcl", replace

/**********************************************/
/* Syntax File 5                              */
/* Sample characteristics                     */
/**********************************************/

use "/Users/pjclare/Dropbox (Sydney Uni)/HRS/Data/HRS Imputed data/final imputed data.dta", clear

forvalues i=2/13 {

qui tab gender if _mi_m==0 & wave==`i' & cohort>0 & laborforcestatus!=6, matcell(mgender)
qui tab ethnicity if _mi_m==0 & wave==`i' & cohort>0 & laborforcestatus!=6, matcell(methnicity)
qui tab cohort if _mi_m==0 & wave==`i' & cohort>0 & laborforcestatus!=6, matcell(mcohort)
qui tab education if _mi_m==0 & wave==`i' & cohort>0 & laborforcestatus!=6, matcell(meducation)
qui tab employ if _mi_m==0 & wave==`i' & cohort>0 & laborforcestatus!=6, matcell(memploy)
qui tab marital if _mi_m==0 & wave==`i' & cohort>0 & laborforcestatus!=6, matcell(mmarital)
qui tab i_religion if _mi_m==0 & wave==`i' & cohort>0 & laborforcestatus!=6, matcell(mi_religion)
qui tab i_birthplace if _mi_m==0 & wave==`i' & cohort>0 & laborforcestatus!=6, matcell(mi_birthplace)
qui tab i_livealone if _mi_m==0 & wave==`i' & cohort>0 & laborforcestatus!=6, matcell(mi_livealone)
qui tab i_livingchildren if _mi_m==0 & wave==`i' & cohort>0 & laborforcestatus!=6, matcell(mi_livingchildren)
qui tab depressed if _mi_m==0 & wave==`i' & cohort>0 & laborforcestatus!=6, matcell(mdepressed)

matrix n`i' = mgender \ methnicity \ mcohort \ meducation \ memploy \ mmarital \ mi_religion \ mi_birthplace \ mi_livealone \ mi_livingchildren \ mdepressed

}

matrix n=n2,n3,n4,n5,n6,n7,n8,n9,n10,n11,n12,n13
matrix list n

misstable summ singleitemlonely gender ethnicity cohort education employ marital i_religion i_birthplace i_livealone i_livingchildren depressed if _mi_m==0 & cohort>0 & laborforcestatus!=6, all
misstable patt singleitemlonely gender ethnicity cohort education employ marital i_religion i_birthplace i_livealone i_livingchildren depressed if _mi_m==0 & cohort>0 & laborforcestatus!=6, asis freq

log close