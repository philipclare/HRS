######################################################################################
##   
## Random Intercept Cross-Lagged Panel Model of Physical Activity and Loneliness
## Data finalise and code
## Date: 5 August 2022
##
######################################################################################
# 1. Setup Environment
#-------------------------------------------------------------------------------------

workdir <- "C:/Users/pcla5984/Dropbox (Sydney Uni)/HRS/Paper 2 - Bidirectional analysis/"

libs <- c("reshape2","fastDummies","dplyr","haven")
missing <- !libs %in% installed.packages()
if (any(missing)) {
  install.packages(libs[missing])
}
lapply(libs, library, character.only = TRUE)


##############################################################################
# 2. Load data and define variable lists
#-----------------------------------------------------------------------------

load(file=paste0(workdir,"Data/Imputed Data - Long Form.RData"))

varlist <- c("id","wave","secu","strata","lonely","vigpa_bin","modpa_bin","cesd_nodeplon","bmi","depressed","gender",
             "employ_1","employ_2","marital_1","marital_2","ethnicity_1","ethnicity_2","ethnicity_3","education_3",
             "education_4","education_5","religion","birthplace","livealone","livingchildren","highbp_ever","cancer_ever",
             "lungdisease_ever","heartprobs_ever","stroke_ever","psychprobs_ever","arthritis_ever")

l_list <- c("lonely1","lonely2","lonely3","lonely4","lonely5","lonely6","lonely7","lonely8")
v_list <- c("vigpa_bin1","vigpa_bin2","vigpa_bin3","vigpa_bin4","vigpa_bin5","vigpa_bin6","vigpa_bin7","vigpa_bin8")
m_list <- c("modpa_bin1","modpa_bin2","modpa_bin3","modpa_bin4","modpa_bin5","modpa_bin6","modpa_bin7","modpa_bin8")
factor_list <- c("secu","strata","religion","birthplace","lonely0","vigpa_bin0","modpa_bin0",
                 "depressed0","gender0","livealone0","livingchildren0","highbp_ever0","cancer_ever0","lungdisease_ever0","heartprobs_ever0","stroke_ever0","psychprobs_ever0","arthritis_ever0",
                 "depressed1","gender1","livealone1","livingchildren1","highbp_ever1","cancer_ever1","lungdisease_ever1","heartprobs_ever1","stroke_ever1","psychprobs_ever1","arthritis_ever1",
                 "depressed2","gender2","livealone2","livingchildren2","highbp_ever2","cancer_ever2","lungdisease_ever2","heartprobs_ever2","stroke_ever2","psychprobs_ever2","arthritis_ever2",
                 "depressed3","gender3","livealone3","livingchildren3","highbp_ever3","cancer_ever3","lungdisease_ever3","heartprobs_ever3","stroke_ever3","psychprobs_ever3","arthritis_ever3",
                 "depressed4","gender4","livealone4","livingchildren4","highbp_ever4","cancer_ever4","lungdisease_ever4","heartprobs_ever4","stroke_ever4","psychprobs_ever4","arthritis_ever4",
                 "depressed5","gender5","livealone5","livingchildren5","highbp_ever5","cancer_ever5","lungdisease_ever5","heartprobs_ever5","stroke_ever5","psychprobs_ever5","arthritis_ever5",
                 "depressed6","gender6","livealone6","livingchildren6","highbp_ever6","cancer_ever6","lungdisease_ever6","heartprobs_ever6","stroke_ever6","psychprobs_ever6","arthritis_ever6",
                 "depressed7","gender7","livealone7","livingchildren7","highbp_ever7","cancer_ever7","lungdisease_ever7","heartprobs_ever7","stroke_ever7","psychprobs_ever7","arthritis_ever7",
                 "depressed8","gender8","livealone8","livingchildren8","highbp_ever8","cancer_ever8","lungdisease_ever8","heartprobs_ever8","stroke_ever8","psychprobs_ever8","arthritis_ever8")
o_list <- c("cesd_nodeplon0","cesd_nodeplon1","cesd_nodeplon2","cesd_nodeplon3","cesd_nodeplon4","cesd_nodeplon5","cesd_nodeplon6","cesd_nodeplon7","cesd_nodeplon8")

##############################################################################
# 3. Lapply over list of imputations to dummy code and reshape to wide
#-----------------------------------------------------------------------------

analysis_data <- lapply(imp[1:41], function (x) {
  x <- as.data.frame(x)
  
  x <- dummy_cols(x, select_columns=c("employ","marital","ethnicity","education"),remove_first_dummy = TRUE)
  
  x <- x[,varlist]
  
  x <- zap_label(x)
  x <- zap_labels(x)
  x <- zap_formats(x)
  
  x <- reshape(x, timevar=c("wave"), 
               idvar=c("id"),
               v.names=c("lonely","vigpa_bin","modpa_bin","cesd_nodeplon","bmi","depressed","gender","employ_1",
                         "employ_2","marital_1","marital_2","livealone","livingchildren","highbp_ever","cancer_ever",
                         "lungdisease_ever","heartprobs_ever","stroke_ever","psychprobs_ever","arthritis_ever"),
               sep = "",
               dir="wide")
  
  x[,l_list] <- lapply(x[,l_list], ordered)
  x[,v_list] <- lapply(x[,v_list], ordered)
  x[,m_list] <- lapply(x[,m_list], ordered)
  x
})

##############################################################################
# 4. Create long form data for random intercept models
#-----------------------------------------------------------------------------

long_data <- lapply(analysis_data, function (x) {
  
  x[,l_list] <- lapply(x[,l_list], function (y) {
    as.numeric(levels(y))[y]
  })
  x[,v_list] <- lapply(x[,v_list], function (y) {
    as.numeric(levels(y))[y]
  })
  x[,m_list] <- lapply(x[,m_list], function (y) {
    as.numeric(levels(y))[y]
  })
  x[,factor_list] <- lapply(x[,factor_list], function (y) {
    as.numeric(levels(y))[y]
  })
  x[,o_list] <- lapply(x[,o_list], function (y) {
    as.numeric(levels(y))[y]
  })
  
  x <- reshape(x, timevar=c("wave"), 
               idvar=c("id"),
               v.names=c("lonely","vigpa_bin","modpa_bin","cesd_nodeplon","bmi","depressed","gender","employ_1",
                         "employ_2","marital_1","marital_2","livealone","livingchildren","highbp_ever","cancer_ever",
                         "lungdisease_ever","heartprobs_ever","stroke_ever","psychprobs_ever","arthritis_ever"),
               sep = "",
               dir="long")
  
  x <- x %>%
    arrange(id) %>%
    group_by(id) %>%
    mutate(flonely = dplyr::lead(lonely, n = 1, default = NA, order_by=wave))
  
  x <- x %>%
    arrange(id) %>%
    group_by(id) %>%
    mutate(fvigpa_bin = dplyr::lead(vigpa_bin, n = 1, default = NA, order_by=wave))
  
  x <- x %>%
    arrange(id) %>%
    group_by(id) %>%
    mutate(fmodpa_bin = dplyr::lead(modpa_bin, n = 1, default = NA, order_by=wave))
  
})


long_data <- lapply(seq(1,41), function (x) {
  long_data[[x]]$imp <- x
  long_data[[x]]
})
long_data[[41]]$imp <- 0

stata_data <- do.call(rbind,long_data)

##############################################################################
# 5. Save final analysis data
#-----------------------------------------------------------------------------

save(analysis_data,file=paste0(workdir,"Data/Final Analysis Data.RData"))
save(long_data,file=paste0(workdir,"Data/Final Analysis Data - Long.RData"))
write_dta(stata_data,path=paste0(workdir,"Data/Final Analysis Data - Long.dta"))

