
use "D:/Dropbox (Sydney Uni)/HRS/Paper 2 - Bidirectional analysis/Data/Clean for imputation 20220711.dta", clear

drop if cohort==0

tab gender if wave==6, matcell(t1)
tab ethnicity if wave==6, matcell(t2)
tab cohort if wave==6, matcell(t3)
tab education if wave==6, matcell(t4)
tab employ if wave==6, matcell(t5)
tab marital if wave==6, matcell(t6)
tab birthplace if wave==6, matcell(t7)
tab religion if wave==6, matcell(t8)

matrix res=t1\t2\t3\t4\t5\t6\t7\t8

matrix list res