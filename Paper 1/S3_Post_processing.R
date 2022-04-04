##############################################################################
# PROGRAM: S2a-suicide-imputation-mice.R
# PURPOSE: Suicide Paper Imputation Using mice in parallel on Katana
# WRITTEN BY: Philip Clare & Phillip Hungerford
# DATE: 03/02/2021
##############################################################################
# 1. Setup Environment
#-----------------------------------------------------------------------------
# 1.0 Time Imputation
start_time <- Sys.time()

# 1.1 Specify paths
# # Mac
# .libPaths("/Users/pjclare/Dropbox (Sydney Uni)/R Library Mac")
# workdir <- "/Users/pjclare/Dropbox (Sydney Uni)/HRS/"

# Windows
.libPaths("C:/Users/pjclare/Dropbox (Sydney Uni)/R Library Windows")
workdir <- "C:/Users/pjclare/Dropbox (Sydney Uni)/HRS/"

# 1.2 Check install and load required libraries
libs <- c("randomForest","mice","miceadds","haven","rpart","VIM","semTools")
missing <- !libs %in% installed.packages()
if (any(missing)) {
  install.packages(libs[missing])
}

library(parallel)
lapply(libs, library, character.only = TRUE)

load("C:/Users/pjclare/Dropbox (Sydney Uni)/HRS/Data/HRS Data Clean 20210611.RData")
imputed<-NULL
imputed <- lapply(seq(1,50), function (i) {
  load(paste0("C:/Users/pjclare/Dropbox (Sydney Uni)/HRS/Data/Imputed data/imputed-mice-",i,".RData"))
  imp_mice[[1]]$imp <- i
  x <- as.data.frame(imp_mice[[1]])
  x$hispanic <- as.numeric(levels(x$hispanic))[x$hispanic]
  x$singleitemlonely <- as.numeric(levels(x$singleitemlonely))[x$singleitemlonely]
  x$depressed <- as.numeric(levels(x$depressed))[x$depressed]
  
  x$laborforcestatus <- as.numeric(levels(x$laborforcestatus))[x$laborforcestatus]
  x$birthplace <- as.numeric(levels(x$birthplace))[x$birthplace]
  x$race <- as.numeric(levels(x$race))[x$race]
  x$education <- as.numeric(levels(x$education))[x$education]
  x$maritalstatus <- as.numeric(levels(x$maritalstatus))[x$maritalstatus]
  x$religion <- as.numeric(levels(x$religion))[x$religion]
  
  x$selfreporthealth <- as.numeric(levels(x$selfreporthealth))[x$selfreporthealth]
  x$selfreporthealthchange <- as.numeric(levels(x$selfreporthealthchange))[x$selfreporthealthchange]
  x$scalelonely <- as.numeric(levels(x$scalelonely))[x$scalelonely]
  x
})

datalong$imp <- 0

datalong <- zap_formats(datalong)
datalong <- zap_labels(datalong)

datalong$birthyear <- datalong$birthyear-1890

imputed[[51]] <- as.data.frame(datalong)

imp_final <- do.call("rbind", imputed)

save(imputed,file="C:/Users/pjclare/Dropbox (Sydney Uni)/HRS/Data/Imputed data/imputed-mice-combined.RData")
write_dta(imp_final,path="C:/Users/pjclare/Dropbox (Sydney Uni)/HRS/Data/Imputed data/imputed-mice-combined.dta")
