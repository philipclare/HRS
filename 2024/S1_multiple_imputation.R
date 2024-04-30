######################################################################################
##   
## Random Intercept Cross-Lagged Panel Model of Physical Activity and Loneliness
## Multiple imputation
## Date: 5 August 2022
##
######################################################################################
# 1. Setup Environment
#-------------------------------------------------------------------------------------

.libPaths("D:/Dropbox (Sydney Uni)/R Library Windows")
workdir <- "D:/Dropbox (Sydney Uni)/HRS/Paper 2 - Bidirectional analysis/"

libs <- c("mice","miceadds","pan","haven","plyr","readr","norm2","dplyr","VIM")
missing <- !libs %in% installed.packages()
if (any(missing)) {
  install.packages(libs[missing])
}
library ("mice")
library ("miceadds")
library ("pan")
library ("haven")
library ("plyr")
library ("readr")
library ("norm2")
library ("dplyr")
library ("VIM")

set.seed(416515)

##############################################################################
# 2. Load data and define factors
#-----------------------------------------------------------------------------

dataread <- read_dta("D:/Dropbox (Sydney Uni)/HRS/Paper 2 - Bidirectional analysis/Data/Clean for imputation 20220711.dta") 

dataread <- zap_label(dataread)
dataread <- zap_labels(dataread)
dataread <- zap_formats(dataread)

factor_list <- c("secu","strata","gender","ethnicity","education","religion","birthplace","depressed",
                 "employ","marital","highbp_ever","cancer_ever","lungdisease_ever","heartprobs_ever",
                 "stroke_ever","psychprobs_ever","arthritis_ever","livealone","livingchildren","lonely","vigpa_bin","modpa_bin")
ordered_list <- c("wave","cesd_nodeplon")
dataread[,factor_list] <- lapply(dataread[,factor_list], factor)
dataread[,ordered_list] <- lapply(dataread[,ordered_list], ordered)

# Sort data from most to least missing, saving order to return data to original order if needed
res<-summary(aggr(dataread))$missings
varorder <- res$Variable
res<-res[order(-res$Count),]
dataimp <- dataread[,res$Variable]

##############################################################################
# 3. Define Imputation Parameters
#-----------------------------------------------------------------------------

m <- 40 # number of imputations
n <- 4 # number of cores for parlmice to use
nimpcore <- m/n
maxit <- 10; # Number of mice iterations
default <- c("cart","rf","rf","rf") # Manually defined list of methods for each variable type

##############################################################################
# 4. Run multiple imputation using MICE with random forests
#-----------------------------------------------------------------------------

# 4.1 Imputation using mice
# imp_mice <- mice(data=dataimp,
#                  m=m,
#                  maxit=maxit,
#                  defaultMethod=default)
imp_mice <- parlmice(data=dataimp,m=m,
                     n.core=n,
                     n.imp.core=nimpcore,
                     maxit=maxit,
                     defaultMethod=default,
                     clusterseed=641631)

imp <- mids2datlist(imp_mice)

##############################################################################
# 4. Create pain scale scores and code bmi
#-----------------------------------------------------------------------------

imp <- lapply(seq(1,m),function (x) {
  imp[[x]]$imp <- x
  imp[[x]]
})

dataimp$imp <- 0
imp[[m+1]] <- as.data.frame(dataimp)

imp_stata <- do.call(rbind, imp)

imp_stata[,factor_list] <- lapply(imp_stata[,factor_list], function (x) {
  as.numeric(levels(x))[x]
  })
imp_stata[,ordered_list] <- lapply(imp_stata[,ordered_list], function (x) {
  as.numeric(levels(x))[x]
})

##############################################################################
# 5. Save data for use in R or Stata
#-----------------------------------------------------------------------------

save(imp,file=paste0(workdir,"Data/Imputed Data - Long Form.RData"))
write_dta(imp_stata,path=paste0(workdir,"Data/Imputed Data - Long Form.dta"))

