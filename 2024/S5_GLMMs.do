use "C:/Users/pcla5984/Dropbox (Sydney Uni)/HRS/Paper 2 - Bidirectional analysis/Data/Final Analysis Data - Long.dta", clear

drop flonely fvigpa_bin fmodpa_bin


egen newid=group(imp id)
xtset newid wave
gen flonely=f1.lonely
gen fvigpa_bin=f1.vigpa_bin
gen fmodpa_bin=f1.modpa_bin
drop newid

mi import flong, m(imp) id(id wave) imputed(ethnicity_1 ethnicity_2 ethnicity_3 education_3 education_4 education_5 religion birthplace lonely vigpa_bin modpa_bin cesd_nodeplon bmi depressed gender employ_1 employ_2 marital_1 marital_2 livealone livingchildren highbp_ever cancer_ever lungdisease_ever heartprobs_ever stroke_ever psychprobs_ever arthritis_ever) clear

mi xtset id wave

/* Analysis version 1 */
mi estimate, dots cmdok irr: mepoisson lonely modpa_bin || id:, vce(robust)
mi estimate, dots cmdok irr: mepoisson lonely vigpa_bin || id:, vce(robust)
mi estimate, dots cmdok irr: mepoisson lonely wave || id:, vce(robust)

mi estimate, dots cmdok irr: mepoisson lonely modpa_bin vigpa_bin wave ///
gender ethnicity_1 ethnicity_2 ethnicity_3 education_3 education_4 education_5 religion birthplace ///
cesd_nodeplon bmi depressed employ_1 employ_2 marital_1 marital_2 livealone livingchildren || id:, vce(robust)

mi estimate, dots cmdok irr: mepoisson flonely modpa_bin || id:, vce(robust)
mi estimate, dots cmdok irr: mepoisson flonely vigpa_bin || id:, vce(robust)
mi estimate, dots cmdok irr: mepoisson flonely wave || id:, vce(robust)

mi estimate, dots cmdok irr: mepoisson flonely modpa_bin vigpa_bin wave ///
gender ethnicity_1 ethnicity_2 ethnicity_3 education_3 education_4 education_5 religion birthplace ///
cesd_nodeplon bmi depressed employ_1 employ_2 marital_1 marital_2 livealone livingchildren || id:, vce(robust)

/* Analysis version 2 */
mi estimate, dots cmdok irr: mepoisson flonely lonely vigpa_bin modpa_bin wave ///
gender ethnicity_1 ethnicity_2 ethnicity_3 education_3 education_4 education_5 religion birthplace ///
cesd_nodeplon bmi depressed employ_1 employ_2 marital_1 marital_2 livealone livingchildren || id:, vce(robust)

mi estimate, dots cmdok irr: mepoisson fvigpa_bin lonely vigpa_bin modpa_bin wave ///
gender ethnicity_1 ethnicity_2 ethnicity_3 education_3 education_4 education_5 religion birthplace ///
cesd_nodeplon bmi depressed employ_1 employ_2 marital_1 marital_2 livealone livingchildren || id:, vce(robust)

mi estimate, dots cmdok irr: mepoisson fmodpa_bin lonely vigpa_bin modpa_bin wave ///
gender ethnicity_1 ethnicity_2 ethnicity_3 education_3 education_4 education_5 religion birthplace ///
cesd_nodeplon bmi depressed employ_1 employ_2 marital_1 marital_2 livealone livingchildren || id:, vce(robust)