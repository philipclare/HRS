######################################################################################
##   
## Random Intercept Cross-Lagged Panel Model of Physical Activity and Loneliness
## Data finalise and code
## Date: 5 August 2022
##
######################################################################################
# 1. Setup Environment
#-------------------------------------------------------------------------------------

workdir <- "D:/Dropbox (Sydney Uni)/HRS/Paper 2 - Bidirectional analysis/"

libs <- c("lavaan","haven","Amelia","matlib")
missing <- !libs %in% installed.packages()
if (any(missing)) {
  install.packages(libs[missing])
}
require(lavaan)
require(haven)
require(Amelia)
require(parallel)

##############################################################################
# 2. Load data and define variable lists
#-----------------------------------------------------------------------------

load(paste0(workdir,"Data/Final Analysis Data.RData"))

##############################################################################
# 3. Define SEM models for Lavaan
#-----------------------------------------------------------------------------

RICLPMunadj <- '
  # Create between components (random intercepts)
  RIlonely =~ 1*lonely1 + 1*lonely2 + 1*lonely3 + 1*lonely4 + 1*lonely5 + 1*lonely6 + 1*lonely7 + 1*lonely8
  RIvigpa_bin =~ 1*vigpa_bin1 + 1*vigpa_bin2 + 1*vigpa_bin3 + 1*vigpa_bin4 + 1*vigpa_bin5 + 1*vigpa_bin6 + 1*vigpa_bin7 + 1*vigpa_bin8
  RImodpa_bin =~ 1*modpa_bin1 + 1*modpa_bin2 + 1*modpa_bin3 + 1*modpa_bin4 + 1*modpa_bin5 + 1*modpa_bin6 + 1*modpa_bin7 + 1*modpa_bin8
  
  # Create within-person centered variables
  wlonely1 =~ 1*lonely1
  wlonely2 =~ 1*lonely2
  wlonely3 =~ 1*lonely3
  wlonely4 =~ 1*lonely4
  wlonely5 =~ 1*lonely5
  wlonely6 =~ 1*lonely6
  wlonely7 =~ 1*lonely7
  wlonely8 =~ 1*lonely8
  wvigpa_bin1 =~ 1*vigpa_bin1
  wvigpa_bin2 =~ 1*vigpa_bin2
  wvigpa_bin3 =~ 1*vigpa_bin3 
  wvigpa_bin4 =~ 1*vigpa_bin4
  wvigpa_bin5 =~ 1*vigpa_bin5
  wvigpa_bin6 =~ 1*vigpa_bin6
  wvigpa_bin7 =~ 1*vigpa_bin7
  wvigpa_bin8 =~ 1*vigpa_bin8
  wmodpa_bin1 =~ 1*modpa_bin1
  wmodpa_bin2 =~ 1*modpa_bin2
  wmodpa_bin3 =~ 1*modpa_bin3 
  wmodpa_bin4 =~ 1*modpa_bin4
  wmodpa_bin5 =~ 1*modpa_bin5
  wmodpa_bin6 =~ 1*modpa_bin6
  wmodpa_bin7 =~ 1*modpa_bin7
  wmodpa_bin8 =~ 1*modpa_bin8
  
  # Estimate the lagged effects between the within-person centered variables.
  wlonely2 ~ l1*wlonely1 + l2*wvigpa_bin1 + l3*wmodpa_bin1
  wlonely3 ~ l1*wlonely2 + l2*wvigpa_bin2 + l3*wmodpa_bin2
  wlonely4 ~ l1*wlonely3 + l2*wvigpa_bin3 + l3*wmodpa_bin3
  wlonely5 ~ l1*wlonely4 + l2*wvigpa_bin4 + l3*wmodpa_bin4
  wlonely6 ~ l1*wlonely5 + l2*wvigpa_bin5 + l3*wmodpa_bin5
  wlonely7 ~ l1*wlonely6 + l2*wvigpa_bin6 + l3*wmodpa_bin6
  wlonely8 ~ l1*wlonely7 + l2*wvigpa_bin7 + l3*wmodpa_bin7
  wvigpa_bin2 ~ v1*wlonely1 + v2*wvigpa_bin1 + v3*wmodpa_bin1
  wvigpa_bin3 ~ v1*wlonely2 + v2*wvigpa_bin2 + v3*wmodpa_bin2
  wvigpa_bin4 ~ v1*wlonely3 + v2*wvigpa_bin3 + v3*wmodpa_bin3
  wvigpa_bin5 ~ v1*wlonely4 + v2*wvigpa_bin4 + v3*wmodpa_bin4
  wvigpa_bin6 ~ v1*wlonely5 + v2*wvigpa_bin5 + v3*wmodpa_bin5
  wvigpa_bin7 ~ v1*wlonely6 + v2*wvigpa_bin6 + v3*wmodpa_bin6
  wvigpa_bin8 ~ v1*wlonely7 + v2*wvigpa_bin7 + v3*wmodpa_bin7
  wmodpa_bin2 ~ m1*wlonely1 + m2*wvigpa_bin1 + m3*wmodpa_bin1
  wmodpa_bin3 ~ m1*wlonely2 + m2*wvigpa_bin2 + m3*wmodpa_bin2
  wmodpa_bin4 ~ m1*wlonely3 + m2*wvigpa_bin3 + m3*wmodpa_bin3
  wmodpa_bin5 ~ m1*wlonely4 + m2*wvigpa_bin4 + m3*wmodpa_bin4
  wmodpa_bin6 ~ m1*wlonely5 + m2*wvigpa_bin5 + m3*wmodpa_bin5
  wmodpa_bin7 ~ m1*wlonely6 + m2*wvigpa_bin6 + m3*wmodpa_bin6
  wmodpa_bin8 ~ m1*wlonely7 + m2*wvigpa_bin7 + m3*wmodpa_bin7
  
  # Constraints
  # 1 Set error variance of observed variables to 0
  lonely1 ~~ 0*lonely1
  lonely2 ~~ 0*lonely2
  lonely3 ~~ 0*lonely3
  lonely4 ~~ 0*lonely4
  lonely5 ~~ 0*lonely5
  lonely6 ~~ 0*lonely6
  lonely7 ~~ 0*lonely7
  lonely8 ~~ 0*lonely8
  vigpa_bin1 ~~ 0*vigpa_bin1
  vigpa_bin2 ~~ 0*vigpa_bin2
  vigpa_bin3 ~~ 0*vigpa_bin3 
  vigpa_bin4 ~~ 0*vigpa_bin4
  vigpa_bin5 ~~ 0*vigpa_bin5
  vigpa_bin6 ~~ 0*vigpa_bin6
  vigpa_bin7 ~~ 0*vigpa_bin7
  vigpa_bin8 ~~ 0*vigpa_bin8
  modpa_bin1 ~~ 0*modpa_bin1
  modpa_bin2 ~~ 0*modpa_bin2
  modpa_bin3 ~~ 0*modpa_bin3 
  modpa_bin4 ~~ 0*modpa_bin4
  modpa_bin5 ~~ 0*modpa_bin5
  modpa_bin6 ~~ 0*modpa_bin6
  modpa_bin7 ~~ 0*modpa_bin7
  modpa_bin8 ~~ 0*modpa_bin8
  
  # 2 Estimate the (residual) variance of the within-person centered variables.
  wlonely1 ~~ 1*wlonely1 
  wvigpa_bin1 ~~ 1*wvigpa_bin1 
  wmodpa_bin1 ~~ 1*wmodpa_bin1
  wlonely2 ~~ varx2*wlonely2 
  wvigpa_bin2 ~~ vary2*wvigpa_bin2 
  wmodpa_bin2 ~~ varz2*wmodpa_bin2
  wlonely3 ~~ varx3*wlonely3 
  wvigpa_bin3 ~~ vary3*wvigpa_bin3 
  wmodpa_bin3 ~~ varz3*wmodpa_bin3 
  wlonely4 ~~ varx4*wlonely4 
  wvigpa_bin4 ~~ vary4*wvigpa_bin4 
  wmodpa_bin4 ~~ varz4*wmodpa_bin4 
  wlonely5 ~~ varx5*wlonely5
  wvigpa_bin5 ~~ vary5*wvigpa_bin5
  wmodpa_bin5 ~~ varz5*wmodpa_bin5 
  wlonely6 ~~ varx6*wlonely6
  wvigpa_bin6 ~~ vary6*wvigpa_bin6
  wmodpa_bin6 ~~ varz6*wmodpa_bin6 
  wlonely7 ~~ varx7*wlonely7
  wvigpa_bin7 ~~ vary7*wvigpa_bin7
  wmodpa_bin7 ~~ varz7*wmodpa_bin7 
  wlonely8 ~~ varx8*wlonely8
  wvigpa_bin8 ~~ vary8*wvigpa_bin8
  wmodpa_bin8 ~~ varz8*wmodpa_bin8 
  
  # 3 Estimate the variance and covariance of the random intercepts. 
  RIvigpa_bin ~~ varix*RIvigpa_bin
  RIlonely ~~ variy*RIlonely
  RImodpa_bin ~~ variz*RImodpa_bin
  RIvigpa_bin ~~ cov1*RIlonely
  RImodpa_bin ~~ cov2*RIlonely
  RIvigpa_bin ~~ cov3*RImodpa_bin
  
  # 4 Constrain covariance between the intercepts and the latents of the first time point to zero
  wlonely1 ~~ 0*RIlonely
  wvigpa_bin1 ~~ 0*RIlonely
  wmodpa_bin1 ~~ 0*RIlonely
  wlonely1 ~~ 0*RIvigpa_bin
  wvigpa_bin1 ~~ 0*RIvigpa_bin
  wmodpa_bin1 ~~ 0*RIvigpa_bin
  wlonely1 ~~ 0*RImodpa_bin
  wvigpa_bin1 ~~ 0*RImodpa_bin
  wmodpa_bin1 ~~ 0*RImodpa_bin
  
  # 5 Estimate the covariance between the within-person centered variables at the first wave. 
  wvigpa_bin1 ~~ er1*wlonely1 # Covariance
  wmodpa_bin1 ~~ er2*wlonely1 # Covariance
  wvigpa_bin1 ~~ er3*wmodpa_bin1 # Covariance
  
  # Estimate the covariances between the residuals of the within-person centered variables (the innovations).
  wvigpa_bin2 ~~ er4*wlonely2
  wmodpa_bin2 ~~ er5*wlonely2
  wvigpa_bin2 ~~ er6*wmodpa_bin2
  wvigpa_bin3 ~~ er4*wlonely3
  wmodpa_bin3 ~~ er5*wlonely3
  wvigpa_bin3 ~~ er6*wmodpa_bin3
  wvigpa_bin4 ~~ er4*wlonely4
  wmodpa_bin4 ~~ er5*wlonely4
  wvigpa_bin4 ~~ er6*wmodpa_bin4
  wvigpa_bin5 ~~ er4*wlonely5
  wmodpa_bin5 ~~ er5*wlonely5
  wvigpa_bin5 ~~ er6*wmodpa_bin5
  wvigpa_bin6 ~~ er4*wlonely6
  wmodpa_bin6 ~~ er5*wlonely6
  wvigpa_bin6 ~~ er6*wmodpa_bin6
  wvigpa_bin7 ~~ er4*wlonely7
  wmodpa_bin7 ~~ er5*wlonely7
  wvigpa_bin7 ~~ er6*wmodpa_bin7
  wvigpa_bin8 ~~ er4*wlonely8
  wmodpa_bin8 ~~ er5*wlonely8
  wvigpa_bin8 ~~ er6*wmodpa_bin8
  
  # 6. Set constraints on mean structure
  lonely1 ~ 1
  modpa_bin1 ~ 1
  vigpa_bin1 ~ 1
  lonely2 ~ 1
  modpa_bin2 ~ 1
  vigpa_bin2 ~ 1
  lonely3 ~ 1
  modpa_bin3 ~ 1
  vigpa_bin3 ~ 1
  lonely4 ~ 1
  modpa_bin4 ~ 1
  vigpa_bin4 ~ 1
  lonely5 ~ 1
  modpa_bin5 ~ 1
  vigpa_bin5 ~ 1
  lonely6 ~ 1
  modpa_bin6 ~ 1
  vigpa_bin6 ~ 1
  lonely7 ~ 1
  modpa_bin7 ~ 1
  vigpa_bin7 ~ 1
  lonely8 ~ 1
  modpa_bin8 ~ 1
  vigpa_bin8 ~ 1

  wlonely1 ~ 0*1
  wmodpa_bin1 ~ 0*1
  wvigpa_bin1 ~ 0*1
  wlonely2 ~ 0*1
  wmodpa_bin2 ~ 0*1
  wvigpa_bin2 ~ 0*1
  wlonely3 ~ 0*1
  wmodpa_bin3 ~ 0*1
  wvigpa_bin3 ~ 0*1
  wlonely4 ~ 0*1
  wmodpa_bin4 ~ 0*1
  wvigpa_bin4 ~ 0*1
  wlonely5 ~ 0*1
  wmodpa_bin5 ~ 0*1
  wvigpa_bin5 ~ 0*1
  wlonely6 ~ 0*1
  wmodpa_bin6 ~ 0*1
  wvigpa_bin6 ~ 0*1
  wlonely7 ~ 0*1
  wmodpa_bin7 ~ 0*1
  wvigpa_bin7 ~ 0*1
  wlonely8 ~ 0*1
  wmodpa_bin8 ~ 0*1
  wvigpa_bin8 ~ 0*1

  RIlonely ~ 0*1
  RIvigpa_bin ~ 0*1
  RImodpa_bin ~ 0*1

  # Regression of observed variables on time-constant covariates.
  lonely1 + lonely2 + lonely3 + lonely4 + lonely5 + lonely6 + lonely7 + lonely8 ~ gender0 + ethnicity_1 + ethnicity_2 + ethnicity_3 + education_3 + education_4 + education_5 + religion + birthplace
  vigpa_bin1 + vigpa_bin2 + vigpa_bin3 + vigpa_bin4 + vigpa_bin5 + vigpa_bin6 + vigpa_bin7 + vigpa_bin8 ~ gender0 + ethnicity_1 + ethnicity_2 + ethnicity_3 + education_3 + education_4 + education_5 + religion + birthplace
  modpa_bin1 + modpa_bin2 + modpa_bin3 + modpa_bin4 + modpa_bin5 + modpa_bin6 + modpa_bin7 + modpa_bin8 ~ gender0 + ethnicity_1 + ethnicity_2 + ethnicity_3 + education_3 + education_4 + education_5 + religion + birthplace

'

RICLPMpartial <- '
  # Create between components (random intercepts)
  RIlonely =~ 1*lonely1 + 1*lonely2 + 1*lonely3 + 1*lonely4 + 1*lonely5 + 1*lonely6 + 1*lonely7 + 1*lonely8
  RIvigpa_bin =~ 1*vigpa_bin1 + 1*vigpa_bin2 + 1*vigpa_bin3 + 1*vigpa_bin4 + 1*vigpa_bin5 + 1*vigpa_bin6 + 1*vigpa_bin7 + 1*vigpa_bin8
  RImodpa_bin =~ 1*modpa_bin1 + 1*modpa_bin2 + 1*modpa_bin3 + 1*modpa_bin4 + 1*modpa_bin5 + 1*modpa_bin6 + 1*modpa_bin7 + 1*modpa_bin8
  
  # Create within-person centered variables
  wlonely1 =~ 1*lonely1
  wlonely2 =~ 1*lonely2
  wlonely3 =~ 1*lonely3
  wlonely4 =~ 1*lonely4
  wlonely5 =~ 1*lonely5
  wlonely6 =~ 1*lonely6
  wlonely7 =~ 1*lonely7
  wlonely8 =~ 1*lonely8
  wvigpa_bin1 =~ 1*vigpa_bin1
  wvigpa_bin2 =~ 1*vigpa_bin2
  wvigpa_bin3 =~ 1*vigpa_bin3 
  wvigpa_bin4 =~ 1*vigpa_bin4
  wvigpa_bin5 =~ 1*vigpa_bin5
  wvigpa_bin6 =~ 1*vigpa_bin6
  wvigpa_bin7 =~ 1*vigpa_bin7
  wvigpa_bin8 =~ 1*vigpa_bin8
  wmodpa_bin1 =~ 1*modpa_bin1
  wmodpa_bin2 =~ 1*modpa_bin2
  wmodpa_bin3 =~ 1*modpa_bin3 
  wmodpa_bin4 =~ 1*modpa_bin4
  wmodpa_bin5 =~ 1*modpa_bin5
  wmodpa_bin6 =~ 1*modpa_bin6
  wmodpa_bin7 =~ 1*modpa_bin7
  wmodpa_bin8 =~ 1*modpa_bin8
  
  # Estimate the lagged effects between the within-person centered variables.
  wlonely2 ~ l1*wlonely1 + l2*wvigpa_bin1 + l3*wmodpa_bin1
  wlonely3 ~ l1*wlonely2 + l2*wvigpa_bin2 + l3*wmodpa_bin2
  wlonely4 ~ l1*wlonely3 + l2*wvigpa_bin3 + l3*wmodpa_bin3
  wlonely5 ~ l1*wlonely4 + l2*wvigpa_bin4 + l3*wmodpa_bin4
  wlonely6 ~ l1*wlonely5 + l2*wvigpa_bin5 + l3*wmodpa_bin5
  wlonely7 ~ l1*wlonely6 + l2*wvigpa_bin6 + l3*wmodpa_bin6
  wlonely8 ~ l1*wlonely7 + l2*wvigpa_bin7 + l3*wmodpa_bin7
  wvigpa_bin2 ~ v1*wlonely1 + v2*wvigpa_bin1 + v3*wmodpa_bin1
  wvigpa_bin3 ~ v1*wlonely2 + v2*wvigpa_bin2 + v3*wmodpa_bin2
  wvigpa_bin4 ~ v1*wlonely3 + v2*wvigpa_bin3 + v3*wmodpa_bin3
  wvigpa_bin5 ~ v1*wlonely4 + v2*wvigpa_bin4 + v3*wmodpa_bin4
  wvigpa_bin6 ~ v1*wlonely5 + v2*wvigpa_bin5 + v3*wmodpa_bin5
  wvigpa_bin7 ~ v1*wlonely6 + v2*wvigpa_bin6 + v3*wmodpa_bin6
  wvigpa_bin8 ~ v1*wlonely7 + v2*wvigpa_bin7 + v3*wmodpa_bin7
  wmodpa_bin2 ~ m1*wlonely1 + m2*wvigpa_bin1 + m3*wmodpa_bin1
  wmodpa_bin3 ~ m1*wlonely2 + m2*wvigpa_bin2 + m3*wmodpa_bin2
  wmodpa_bin4 ~ m1*wlonely3 + m2*wvigpa_bin3 + m3*wmodpa_bin3
  wmodpa_bin5 ~ m1*wlonely4 + m2*wvigpa_bin4 + m3*wmodpa_bin4
  wmodpa_bin6 ~ m1*wlonely5 + m2*wvigpa_bin5 + m3*wmodpa_bin5
  wmodpa_bin7 ~ m1*wlonely6 + m2*wvigpa_bin6 + m3*wmodpa_bin6
  wmodpa_bin8 ~ m1*wlonely7 + m2*wvigpa_bin7 + m3*wmodpa_bin7
  
  # Constraints
  # 1 Set error variance of observed variables to 0
  lonely1 ~~ 0*lonely1
  lonely2 ~~ 0*lonely2
  lonely3 ~~ 0*lonely3
  lonely4 ~~ 0*lonely4
  lonely5 ~~ 0*lonely5
  lonely6 ~~ 0*lonely6
  lonely7 ~~ 0*lonely7
  lonely8 ~~ 0*lonely8
  vigpa_bin1 ~~ 0*vigpa_bin1
  vigpa_bin2 ~~ 0*vigpa_bin2
  vigpa_bin3 ~~ 0*vigpa_bin3 
  vigpa_bin4 ~~ 0*vigpa_bin4
  vigpa_bin5 ~~ 0*vigpa_bin5
  vigpa_bin6 ~~ 0*vigpa_bin6
  vigpa_bin7 ~~ 0*vigpa_bin7
  vigpa_bin8 ~~ 0*vigpa_bin8
  modpa_bin1 ~~ 0*modpa_bin1
  modpa_bin2 ~~ 0*modpa_bin2
  modpa_bin3 ~~ 0*modpa_bin3 
  modpa_bin4 ~~ 0*modpa_bin4
  modpa_bin5 ~~ 0*modpa_bin5
  modpa_bin6 ~~ 0*modpa_bin6
  modpa_bin7 ~~ 0*modpa_bin7
  modpa_bin8 ~~ 0*modpa_bin8
  
  # 2 Estimate the (residual) variance of the within-person centered variables.
  wlonely1 ~~ 1*wlonely1 
  wvigpa_bin1 ~~ 1*wvigpa_bin1 
  wmodpa_bin1 ~~ 1*wmodpa_bin1
  wlonely2 ~~ varx2*wlonely2 
  wvigpa_bin2 ~~ vary2*wvigpa_bin2 
  wmodpa_bin2 ~~ varz2*wmodpa_bin2
  wlonely3 ~~ varx3*wlonely3 
  wvigpa_bin3 ~~ vary3*wvigpa_bin3 
  wmodpa_bin3 ~~ varz3*wmodpa_bin3 
  wlonely4 ~~ varx4*wlonely4 
  wvigpa_bin4 ~~ vary4*wvigpa_bin4 
  wmodpa_bin4 ~~ varz4*wmodpa_bin4 
  wlonely5 ~~ varx5*wlonely5
  wvigpa_bin5 ~~ vary5*wvigpa_bin5
  wmodpa_bin5 ~~ varz5*wmodpa_bin5 
  wlonely6 ~~ varx6*wlonely6
  wvigpa_bin6 ~~ vary6*wvigpa_bin6
  wmodpa_bin6 ~~ varz6*wmodpa_bin6 
  wlonely7 ~~ varx7*wlonely7
  wvigpa_bin7 ~~ vary7*wvigpa_bin7
  wmodpa_bin7 ~~ varz7*wmodpa_bin7 
  wlonely8 ~~ varx8*wlonely8
  wvigpa_bin8 ~~ vary8*wvigpa_bin8
  wmodpa_bin8 ~~ varz8*wmodpa_bin8 
  
  # 3 Estimate the variance and covariance of the random intercepts. 
  RIvigpa_bin ~~ varix*RIvigpa_bin
  RIlonely ~~ variy*RIlonely
  RImodpa_bin ~~ variz*RImodpa_bin
  RIvigpa_bin ~~ covi1*RIlonely
  RImodpa_bin ~~ covi2*RIlonely
  RIvigpa_bin ~~ covi3*RImodpa_bin
  
  # 4 Constrain covariance between the intercepts and the latents of the first time point to zero
  wlonely1 ~~ 0*RIlonely
  wvigpa_bin1 ~~ 0*RIlonely
  wmodpa_bin1 ~~ 0*RIlonely
  wlonely1 ~~ 0*RIvigpa_bin
  wvigpa_bin1 ~~ 0*RIvigpa_bin
  wmodpa_bin1 ~~ 0*RIvigpa_bin
  wlonely1 ~~ 0*RImodpa_bin
  wvigpa_bin1 ~~ 0*RImodpa_bin
  wmodpa_bin1 ~~ 0*RImodpa_bin
  
  # 5 Estimate the covariance between the within-person centered variables at the first wave. 
  wvigpa_bin1 ~~ er1*wlonely1 # Covariance
  wmodpa_bin1 ~~ er2*wlonely1 # Covariance
  wvigpa_bin1 ~~ er3*wmodpa_bin1 # Covariance
  
  # Estimate the covariances between the residuals of the within-person centered variables (the innovations).
  wvigpa_bin2 ~~ er4*wlonely2
  wmodpa_bin2 ~~ er5*wlonely2
  wvigpa_bin2 ~~ er6*wmodpa_bin2
  wvigpa_bin3 ~~ er4*wlonely3
  wmodpa_bin3 ~~ er5*wlonely3
  wvigpa_bin3 ~~ er6*wmodpa_bin3
  wvigpa_bin4 ~~ er4*wlonely4
  wmodpa_bin4 ~~ er5*wlonely4
  wvigpa_bin4 ~~ er6*wmodpa_bin4
  wvigpa_bin5 ~~ er4*wlonely5
  wmodpa_bin5 ~~ er5*wlonely5
  wvigpa_bin5 ~~ er6*wmodpa_bin5
  wvigpa_bin6 ~~ er4*wlonely6
  wmodpa_bin6 ~~ er5*wlonely6
  wvigpa_bin6 ~~ er6*wmodpa_bin6
  wvigpa_bin7 ~~ er4*wlonely7
  wmodpa_bin7 ~~ er5*wlonely7
  wvigpa_bin7 ~~ er6*wmodpa_bin7
  wvigpa_bin8 ~~ er4*wlonely8
  wmodpa_bin8 ~~ er5*wlonely8
  wvigpa_bin8 ~~ er6*wmodpa_bin8
  
  # 6. Set constraints on mean structure
  lonely1 ~ 1
  modpa_bin1 ~ 1
  vigpa_bin1 ~ 1
  lonely2 ~ 1
  modpa_bin2 ~ 1
  vigpa_bin2 ~ 1
  lonely3 ~ 1
  modpa_bin3 ~ 1
  vigpa_bin3 ~ 1
  lonely4 ~ 1
  modpa_bin4 ~ 1
  vigpa_bin4 ~ 1
  lonely5 ~ 1
  modpa_bin5 ~ 1
  vigpa_bin5 ~ 1
  lonely6 ~ 1
  modpa_bin6 ~ 1
  vigpa_bin6 ~ 1
  lonely7 ~ 1
  modpa_bin7 ~ 1
  vigpa_bin7 ~ 1
  lonely8 ~ 1
  modpa_bin8 ~ 1
  vigpa_bin8 ~ 1

  wlonely1 ~ 0*1
  wmodpa_bin1 ~ 0*1
  wvigpa_bin1 ~ 0*1
  wlonely2 ~ 0*1
  wmodpa_bin2 ~ 0*1
  wvigpa_bin2 ~ 0*1
  wlonely3 ~ 0*1
  wmodpa_bin3 ~ 0*1
  wvigpa_bin3 ~ 0*1
  wlonely4 ~ 0*1
  wmodpa_bin4 ~ 0*1
  wvigpa_bin4 ~ 0*1
  wlonely5 ~ 0*1
  wmodpa_bin5 ~ 0*1
  wvigpa_bin5 ~ 0*1
  wlonely6 ~ 0*1
  wmodpa_bin6 ~ 0*1
  wvigpa_bin6 ~ 0*1
  wlonely7 ~ 0*1
  wmodpa_bin7 ~ 0*1
  wvigpa_bin7 ~ 0*1
  wlonely8 ~ 0*1
  wmodpa_bin8 ~ 0*1
  wvigpa_bin8 ~ 0*1

  RIlonely ~ 0*1
  RIvigpa_bin ~ 0*1
  RImodpa_bin ~ 0*1

  # Regression of observed variables on time-constant covariates.
  wlonely1 + wlonely2 + wlonely3 + wlonely4 + wlonely5 + wlonely6 + wlonely7 + wlonely8 ~ gender0 + ethnicity_1 + ethnicity_2 + ethnicity_3 + education_3 + education_4 + education_5 + religion + birthplace
  wvigpa_bin1 + wvigpa_bin2 + wvigpa_bin3 + wvigpa_bin4 + wvigpa_bin5 + wvigpa_bin6 + wvigpa_bin7 + wvigpa_bin8 ~ gender0 + ethnicity_1 + ethnicity_2 + ethnicity_3 + education_3 + education_4 + education_5 + religion + birthplace
  wmodpa_bin1 + wmodpa_bin2 + wmodpa_bin3 + wmodpa_bin4 + wmodpa_bin5 + wmodpa_bin6 + wmodpa_bin7 + wmodpa_bin8 ~ gender0 + ethnicity_1 + ethnicity_2 + ethnicity_3 + education_3 + education_4 + education_5 + religion + birthplace
  
  # Regression of observed variables on time-varying covariates.
  lonely1 + vigpa_bin1 + modpa_bin1 ~ cesd_nodeplon0 + bmi0 + depressed0 + employ_10 + employ_20 + marital_10 + marital_20 + livealone0 + livingchildren0
  lonely2 + vigpa_bin2 + modpa_bin2 ~ cesd_nodeplon1 + bmi1 + depressed1 + employ_11 + employ_21 + marital_11 + marital_21 + livealone1 + livingchildren1
  lonely3 + vigpa_bin3 + modpa_bin3 ~ cesd_nodeplon2 + bmi2 + depressed2 + employ_12 + employ_22 + marital_12 + marital_22 + livealone2 + livingchildren2
  lonely4 + vigpa_bin4 + modpa_bin4 ~ cesd_nodeplon3 + bmi3 + depressed3 + employ_13 + employ_23 + marital_13 + marital_23 + livealone3 + livingchildren3
  lonely5 + vigpa_bin5 + modpa_bin5 ~ cesd_nodeplon4 + bmi4 + depressed4 + employ_14 + employ_24 + marital_14 + marital_24 + livealone4 + livingchildren4
  lonely6 + vigpa_bin6 + modpa_bin6 ~ cesd_nodeplon5 + bmi5 + depressed5 + employ_15 + employ_25 + marital_15 + marital_25 + livealone5 + livingchildren5
  lonely7 + vigpa_bin7 + modpa_bin7 ~ cesd_nodeplon6 + bmi6 + depressed6 + employ_16 + employ_26 + marital_16 + marital_26 + livealone6 + livingchildren6
  lonely8 + vigpa_bin8 + modpa_bin8 ~ cesd_nodeplon7 + bmi7 + depressed7 + employ_17 + employ_27 + marital_17 + marital_27 + livealone7 + livingchildren7

'

RICLPMfully <- '
  # Create between components (random intercepts)
  RIlonely =~ 1*lonely1 + 1*lonely2 + 1*lonely3 + 1*lonely4 + 1*lonely5 + 1*lonely6 + 1*lonely7 + 1*lonely8
  RIvigpa_bin =~ 1*vigpa_bin1 + 1*vigpa_bin2 + 1*vigpa_bin3 + 1*vigpa_bin4 + 1*vigpa_bin5 + 1*vigpa_bin6 + 1*vigpa_bin7 + 1*vigpa_bin8
  RImodpa_bin =~ 1*modpa_bin1 + 1*modpa_bin2 + 1*modpa_bin3 + 1*modpa_bin4 + 1*modpa_bin5 + 1*modpa_bin6 + 1*modpa_bin7 + 1*modpa_bin8
  
  # Create within-person centered variables
  wlonely1 =~ 1*lonely1
  wlonely2 =~ 1*lonely2
  wlonely3 =~ 1*lonely3
  wlonely4 =~ 1*lonely4
  wlonely5 =~ 1*lonely5
  wlonely6 =~ 1*lonely6
  wlonely7 =~ 1*lonely7
  wlonely8 =~ 1*lonely8
  wvigpa_bin1 =~ 1*vigpa_bin1
  wvigpa_bin2 =~ 1*vigpa_bin2
  wvigpa_bin3 =~ 1*vigpa_bin3 
  wvigpa_bin4 =~ 1*vigpa_bin4
  wvigpa_bin5 =~ 1*vigpa_bin5
  wvigpa_bin6 =~ 1*vigpa_bin6
  wvigpa_bin7 =~ 1*vigpa_bin7
  wvigpa_bin8 =~ 1*vigpa_bin8
  wmodpa_bin1 =~ 1*modpa_bin1
  wmodpa_bin2 =~ 1*modpa_bin2
  wmodpa_bin3 =~ 1*modpa_bin3 
  wmodpa_bin4 =~ 1*modpa_bin4
  wmodpa_bin5 =~ 1*modpa_bin5
  wmodpa_bin6 =~ 1*modpa_bin6
  wmodpa_bin7 =~ 1*modpa_bin7
  wmodpa_bin8 =~ 1*modpa_bin8
  
  # Estimate the lagged effects between the within-person centered variables.
  wlonely2 ~ l1*wlonely1 + l2*wvigpa_bin1 + l3*wmodpa_bin1
  wlonely3 ~ l1*wlonely2 + l2*wvigpa_bin2 + l3*wmodpa_bin2
  wlonely4 ~ l1*wlonely3 + l2*wvigpa_bin3 + l3*wmodpa_bin3
  wlonely5 ~ l1*wlonely4 + l2*wvigpa_bin4 + l3*wmodpa_bin4
  wlonely6 ~ l1*wlonely5 + l2*wvigpa_bin5 + l3*wmodpa_bin5
  wlonely7 ~ l1*wlonely6 + l2*wvigpa_bin6 + l3*wmodpa_bin6
  wlonely8 ~ l1*wlonely7 + l2*wvigpa_bin7 + l3*wmodpa_bin7
  wvigpa_bin2 ~ v1*wlonely1 + v2*wvigpa_bin1 + v3*wmodpa_bin1
  wvigpa_bin3 ~ v1*wlonely2 + v2*wvigpa_bin2 + v3*wmodpa_bin2
  wvigpa_bin4 ~ v1*wlonely3 + v2*wvigpa_bin3 + v3*wmodpa_bin3
  wvigpa_bin5 ~ v1*wlonely4 + v2*wvigpa_bin4 + v3*wmodpa_bin4
  wvigpa_bin6 ~ v1*wlonely5 + v2*wvigpa_bin5 + v3*wmodpa_bin5
  wvigpa_bin7 ~ v1*wlonely6 + v2*wvigpa_bin6 + v3*wmodpa_bin6
  wvigpa_bin8 ~ v1*wlonely7 + v2*wvigpa_bin7 + v3*wmodpa_bin7
  wmodpa_bin2 ~ m1*wlonely1 + m2*wvigpa_bin1 + m3*wmodpa_bin1
  wmodpa_bin3 ~ m1*wlonely2 + m2*wvigpa_bin2 + m3*wmodpa_bin2
  wmodpa_bin4 ~ m1*wlonely3 + m2*wvigpa_bin3 + m3*wmodpa_bin3
  wmodpa_bin5 ~ m1*wlonely4 + m2*wvigpa_bin4 + m3*wmodpa_bin4
  wmodpa_bin6 ~ m1*wlonely5 + m2*wvigpa_bin5 + m3*wmodpa_bin5
  wmodpa_bin7 ~ m1*wlonely6 + m2*wvigpa_bin6 + m3*wmodpa_bin6
  wmodpa_bin8 ~ m1*wlonely7 + m2*wvigpa_bin7 + m3*wmodpa_bin7
  
  # Constraints
  # 1 Set error variance of observed variables to 0
  lonely1 ~~ 0*lonely1
  lonely2 ~~ 0*lonely2
  lonely3 ~~ 0*lonely3
  lonely4 ~~ 0*lonely4
  lonely5 ~~ 0*lonely5
  lonely6 ~~ 0*lonely6
  lonely7 ~~ 0*lonely7
  lonely8 ~~ 0*lonely8
  vigpa_bin1 ~~ 0*vigpa_bin1
  vigpa_bin2 ~~ 0*vigpa_bin2
  vigpa_bin3 ~~ 0*vigpa_bin3 
  vigpa_bin4 ~~ 0*vigpa_bin4
  vigpa_bin5 ~~ 0*vigpa_bin5
  vigpa_bin6 ~~ 0*vigpa_bin6
  vigpa_bin7 ~~ 0*vigpa_bin7
  vigpa_bin8 ~~ 0*vigpa_bin8
  modpa_bin1 ~~ 0*modpa_bin1
  modpa_bin2 ~~ 0*modpa_bin2
  modpa_bin3 ~~ 0*modpa_bin3 
  modpa_bin4 ~~ 0*modpa_bin4
  modpa_bin5 ~~ 0*modpa_bin5
  modpa_bin6 ~~ 0*modpa_bin6
  modpa_bin7 ~~ 0*modpa_bin7
  modpa_bin8 ~~ 0*modpa_bin8
  
  # 2 Estimate the (residual) variance of the within-person centered variables.
  wlonely1 ~~ 1*wlonely1 
  wvigpa_bin1 ~~ 1*wvigpa_bin1 
  wmodpa_bin1 ~~ 1*wmodpa_bin1
  wlonely2 ~~ varx2*wlonely2 
  wvigpa_bin2 ~~ vary2*wvigpa_bin2 
  wmodpa_bin2 ~~ varz2*wmodpa_bin2
  wlonely3 ~~ varx3*wlonely3 
  wvigpa_bin3 ~~ vary3*wvigpa_bin3 
  wmodpa_bin3 ~~ varz3*wmodpa_bin3 
  wlonely4 ~~ varx4*wlonely4 
  wvigpa_bin4 ~~ vary4*wvigpa_bin4 
  wmodpa_bin4 ~~ varz4*wmodpa_bin4 
  wlonely5 ~~ varx5*wlonely5
  wvigpa_bin5 ~~ vary5*wvigpa_bin5
  wmodpa_bin5 ~~ varz5*wmodpa_bin5 
  wlonely6 ~~ varx6*wlonely6
  wvigpa_bin6 ~~ vary6*wvigpa_bin6
  wmodpa_bin6 ~~ varz6*wmodpa_bin6 
  wlonely7 ~~ varx7*wlonely7
  wvigpa_bin7 ~~ vary7*wvigpa_bin7
  wmodpa_bin7 ~~ varz7*wmodpa_bin7 
  wlonely8 ~~ varx8*wlonely8
  wvigpa_bin8 ~~ vary8*wvigpa_bin8
  wmodpa_bin8 ~~ varz8*wmodpa_bin8 
  
  # 3 Estimate the variance and covariance of the random intercepts. 
  RIvigpa_bin ~~ varix*RIvigpa_bin
  RIlonely ~~ variy*RIlonely
  RImodpa_bin ~~ variz*RImodpa_bin
  RIvigpa_bin ~~ covi1*RIlonely
  RImodpa_bin ~~ covi2*RIlonely
  RIvigpa_bin ~~ covi3*RImodpa_bin
  
  # 4 Constrain covariance between the intercepts and the latents of the first time point to zero
  wlonely1 ~~ 0*RIlonely
  wvigpa_bin1 ~~ 0*RIlonely
  wmodpa_bin1 ~~ 0*RIlonely
  wlonely1 ~~ 0*RIvigpa_bin
  wvigpa_bin1 ~~ 0*RIvigpa_bin
  wmodpa_bin1 ~~ 0*RIvigpa_bin
  wlonely1 ~~ 0*RImodpa_bin
  wvigpa_bin1 ~~ 0*RImodpa_bin
  wmodpa_bin1 ~~ 0*RImodpa_bin
  
  # 5 Estimate the covariance between the within-person centered variables at the first wave. 
  wvigpa_bin1 ~~ er1*wlonely1 # Covariance
  wmodpa_bin1 ~~ er2*wlonely1 # Covariance
  wvigpa_bin1 ~~ er3*wmodpa_bin1 # Covariance
  
  # Estimate the covariances between the residuals of the within-person centered variables (the innovations).
  wvigpa_bin2 ~~ er4*wlonely2
  wmodpa_bin2 ~~ er5*wlonely2
  wvigpa_bin2 ~~ er6*wmodpa_bin2
  wvigpa_bin3 ~~ er4*wlonely3
  wmodpa_bin3 ~~ er5*wlonely3
  wvigpa_bin3 ~~ er6*wmodpa_bin3
  wvigpa_bin4 ~~ er4*wlonely4
  wmodpa_bin4 ~~ er5*wlonely4
  wvigpa_bin4 ~~ er6*wmodpa_bin4
  wvigpa_bin5 ~~ er4*wlonely5
  wmodpa_bin5 ~~ er5*wlonely5
  wvigpa_bin5 ~~ er6*wmodpa_bin5
  wvigpa_bin6 ~~ er4*wlonely6
  wmodpa_bin6 ~~ er5*wlonely6
  wvigpa_bin6 ~~ er6*wmodpa_bin6
  wvigpa_bin7 ~~ er4*wlonely7
  wmodpa_bin7 ~~ er5*wlonely7
  wvigpa_bin7 ~~ er6*wmodpa_bin7
  wvigpa_bin8 ~~ er4*wlonely8
  wmodpa_bin8 ~~ er5*wlonely8
  wvigpa_bin8 ~~ er6*wmodpa_bin8
  
  # 6. Set constraints on mean structure
  lonely1 ~ 1
  modpa_bin1 ~ 1
  vigpa_bin1 ~ 1
  lonely2 ~ 1
  modpa_bin2 ~ 1
  vigpa_bin2 ~ 1
  lonely3 ~ 1
  modpa_bin3 ~ 1
  vigpa_bin3 ~ 1
  lonely4 ~ 1
  modpa_bin4 ~ 1
  vigpa_bin4 ~ 1
  lonely5 ~ 1
  modpa_bin5 ~ 1
  vigpa_bin5 ~ 1
  lonely6 ~ 1
  modpa_bin6 ~ 1
  vigpa_bin6 ~ 1
  lonely7 ~ 1
  modpa_bin7 ~ 1
  vigpa_bin7 ~ 1
  lonely8 ~ 1
  modpa_bin8 ~ 1
  vigpa_bin8 ~ 1

  wlonely1 ~ 0*1
  wmodpa_bin1 ~ 0*1
  wvigpa_bin1 ~ 0*1
  wlonely2 ~ 0*1
  wmodpa_bin2 ~ 0*1
  wvigpa_bin2 ~ 0*1
  wlonely3 ~ 0*1
  wmodpa_bin3 ~ 0*1
  wvigpa_bin3 ~ 0*1
  wlonely4 ~ 0*1
  wmodpa_bin4 ~ 0*1
  wvigpa_bin4 ~ 0*1
  wlonely5 ~ 0*1
  wmodpa_bin5 ~ 0*1
  wvigpa_bin5 ~ 0*1
  wlonely6 ~ 0*1
  wmodpa_bin6 ~ 0*1
  wvigpa_bin6 ~ 0*1
  wlonely7 ~ 0*1
  wmodpa_bin7 ~ 0*1
  wvigpa_bin7 ~ 0*1
  wlonely8 ~ 0*1
  wmodpa_bin8 ~ 0*1
  wvigpa_bin8 ~ 0*1

  RIlonely ~ 0*1
  RIvigpa_bin ~ 0*1
  RImodpa_bin ~ 0*1

  # Regression of observed variables on time-constant covariates.
  wlonely1 + wlonely2 + wlonely3 + wlonely4 + wlonely5 + wlonely6 + wlonely7 + wlonely8 ~ gender0 + ethnicity_1 + ethnicity_2 + ethnicity_3 + education_3 + education_4 + education_5 + religion + birthplace
  wvigpa_bin1 + wvigpa_bin2 + wvigpa_bin3 + wvigpa_bin4 + wvigpa_bin5 + wvigpa_bin6 + wvigpa_bin7 + wvigpa_bin8 ~ gender0 + ethnicity_1 + ethnicity_2 + ethnicity_3 + education_3 + education_4 + education_5 + religion + birthplace
  wmodpa_bin1 + wmodpa_bin2 + wmodpa_bin3 + wmodpa_bin4 + wmodpa_bin5 + wmodpa_bin6 + wmodpa_bin7 + wmodpa_bin8 ~ gender0 + ethnicity_1 + ethnicity_2 + ethnicity_3 + education_3 + education_4 + education_5 + religion + birthplace
  
  # Regression of observed variables on time-varying covariates.
  lonely1 + vigpa_bin1 + modpa_bin1 ~ cesd_nodeplon0 + bmi0 + depressed0 + employ_10 + employ_20 + marital_10 + marital_20 + livealone0 + livingchildren0 + highbp_ever0 + cancer_ever0 + lungdisease_ever0 + heartprobs_ever0 + stroke_ever0 + psychprobs_ever0 + arthritis_ever0
  lonely2 + vigpa_bin2 + modpa_bin2 ~ cesd_nodeplon1 + bmi1 + depressed1 + employ_11 + employ_21 + marital_11 + marital_21 + livealone1 + livingchildren1 + highbp_ever1 + cancer_ever1 + lungdisease_ever1 + heartprobs_ever1 + stroke_ever1 + psychprobs_ever1 + arthritis_ever1
  lonely3 + vigpa_bin3 + modpa_bin3 ~ cesd_nodeplon2 + bmi2 + depressed2 + employ_12 + employ_22 + marital_12 + marital_22 + livealone2 + livingchildren2 + highbp_ever2 + cancer_ever2 + lungdisease_ever2 + heartprobs_ever2 + stroke_ever2 + psychprobs_ever2 + arthritis_ever2
  lonely4 + vigpa_bin4 + modpa_bin4 ~ cesd_nodeplon3 + bmi3 + depressed3 + employ_13 + employ_23 + marital_13 + marital_23 + livealone3 + livingchildren3 + highbp_ever3 + cancer_ever3 + lungdisease_ever3 + heartprobs_ever3 + stroke_ever3 + psychprobs_ever3 + arthritis_ever3
  lonely5 + vigpa_bin5 + modpa_bin5 ~ cesd_nodeplon4 + bmi4 + depressed4 + employ_14 + employ_24 + marital_14 + marital_24 + livealone4 + livingchildren4 + highbp_ever4 + cancer_ever4 + lungdisease_ever4 + heartprobs_ever4 + stroke_ever4 + psychprobs_ever4 + arthritis_ever4
  lonely6 + vigpa_bin6 + modpa_bin6 ~ cesd_nodeplon5 + bmi5 + depressed5 + employ_15 + employ_25 + marital_15 + marital_25 + livealone5 + livingchildren5 + highbp_ever5 + cancer_ever5 + lungdisease_ever5 + heartprobs_ever5 + stroke_ever5 + psychprobs_ever5 + arthritis_ever5
  lonely7 + vigpa_bin7 + modpa_bin7 ~ cesd_nodeplon6 + bmi6 + depressed6 + employ_16 + employ_26 + marital_16 + marital_26 + livealone6 + livingchildren6 + highbp_ever6 + cancer_ever6 + lungdisease_ever6 + heartprobs_ever6 + stroke_ever6 + psychprobs_ever6 + arthritis_ever6
  lonely8 + vigpa_bin8 + modpa_bin8 ~ cesd_nodeplon7 + bmi7 + depressed7 + employ_17 + employ_27 + marital_17 + marital_27 + livealone7 + livingchildren7 + highbp_ever7 + cancer_ever7 + lungdisease_ever7 + heartprobs_ever7 + stroke_ever7 + psychprobs_ever7 + arthritis_ever7

'

##############################################################################
# 4. Create clusters to increase processing speed
#-----------------------------------------------------------------------------

numcores <- 6
cl <- parallel::makeCluster(numcores)
parallel::clusterEvalQ(cl, .libPaths("D:/Dropbox (Sydney Uni)/R Library Windows"))
parallel::clusterEvalQ(cl, workdir <- "D:/Dropbox (Sydney Uni)/HRS/Paper 2 - Bidirectional analysis/")
parallel::clusterEvalQ(cl, library("lavaan"))
parallel::clusterExport(cl, list("analysis_data","RICLPMunadj","RICLPMpartial","RICLPMfully"))

##############################################################################
# 5. Fit RI-CLPM Models using Lavaan
#-----------------------------------------------------------------------------

RICLPMunadj.fit <- parLapply(cl,analysis_data, function (x) {
  lavaan(RICLPMunadj, data = x, estimator="DWLS", optim.method="BFGS", check.gradient = FALSE)
})

RICLPMpartial.fit <- parLapply(cl,analysis_data, function (x) {
  lavaan(RICLPMpartial, data = x, estimator="DWLS", optim.method="BFGS", check.gradient = FALSE)
})

RICLPMfully.fit <- parLapply(cl,analysis_data, function (x) {
  lavaan(RICLPMfully, data = x, estimator="DWLS", optim.method="BFGS", check.gradient = FALSE)
})

##############################################################################
# 6. Save results for subsequent pooling
#-----------------------------------------------------------------------------

save(RICLPMunadj.fit,file=paste0(workdir,"Results/Unadjusted model fits.RData"))
save(RICLPMpartial.fit,file=paste0(workdir,"Results/Partially adjusted model fits.RData"))
save(RICLPMfully.fit,file=paste0(workdir,"Results/Fully adjusted model fits.RData"))
