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
# Windows
.libPaths("/Users/pjclare/Dropbox (Sydney Uni)/R Library Windows")
workdir <- "/Users/pjclare/Dropbox (Sydney Uni)/HRS/"

# # Katana
# .libPaths("/home/z3312911/RPackages")
# workdir <- "/home/z3312911/hrs-imputation/"

# 1.2 Check install and load required libraries
libs <- c("randomForest","mice","miceadds","haven","rpart","VIM","semTools")
missing <- !libs %in% installed.packages()
if (any(missing)) {
  install.packages(libs[missing])
}

library(parallel)
lapply(libs, library, character.only = TRUE)

# 1.3 Define arguments passed to R by bash
args <- commandArgs(trailingOnly = TRUE)
args <- 1

##############################################################################
# 2.Load data
#-----------------------------------------------------------------------------
# datalong <- read_dta(file=paste0(workdir,"HRS Data Clean.dta"))
# save(datalong,file=paste0(workdir,"HRS Data Clean.RData"))
load(file=paste0(workdir,"Data/seeds.RData"))
set.seed(eval(as.name("seeds"))[as.numeric(args[1])])
load(file=paste0(workdir,"Data/HRS Data Clean 20210526.RData")) # In this case, the data frame object in this file is named 'datalong'

datalong <- zap_formats(datalong)
datalong <- zap_labels(datalong)

datalong$hispanic <- factor(datalong$hispanic)
datalong$singleitemlonely <- factor(datalong$singleitemlonely)
datalong$depressed <- factor(datalong$depressed)

datalong$laborforcestatus <- factor(datalong$laborforcestatus)
datalong$birthplace <- factor(datalong$birthplace)
datalong$race <- factor(datalong$race)
datalong$education <- factor(datalong$education)
datalong$maritalstatus <- factor(datalong$maritalstatus)
datalong$religion <- factor(datalong$religion)

datalong$selfreporthealth <- ordered(datalong$selfreporthealth)
datalong$selfreporthealthchange <- ordered(datalong$selfreporthealthchange)
datalong$scalelonely <- ordered(datalong$scalelonely)

datalong$birthyear <- datalong$birthyear-1890

res<-summary(aggr(datalong))$missings
varorder <- res$Variable
res<-res[order(-res$Count),]
datalong <- datalong[,res$Variable]

# datalong_suba <- datalong[,-c(2,3)]

##############################################################################
# 3. Define Imputation Parameters
#-----------------------------------------------------------------------------

# m <- 40 # Number of imputations
maxit <- 10; # Number of mice iterations
# set.seed(15681) # Not the seed used by parlmice, but needs to be set or parlmice fails
# cluster.seed <- 48770 # Needs to be set within function for parallel computing
# numcores <- 20 #as.numeric(Sys.getenv('NCPUS')) # Number of cores to use (default = ncore-1)
# n.imp.core <- m/numcores # number of imputations per core (default = 2)
# cl.type <- "FORK" # Can be PSOCK on Windows or FORK for *NIX based systems
method <- c("cart","cart","cart","cart","logreg","logreg","cart","rf","rf","cart",
            "cart","rf","rf","rf","logreg","rf","","","","","")
init <- mice(datalong, print = FALSE, m=1, maxit=0)
pmat <- init$predictorMatrix
pmat[,c(2,3)] <- 0
pmat[c(17,18,19,20,21),] <- 0

##############################################################################
# 4. Imputation
#-----------------------------------------------------------------------------
start_time <- Sys.time()
# 3.3 Parallel imputation using parlmice
imp_mice <- mice(m=1,
                 data=datalong,
                 maxit=maxit,
                 method=method,
                 predictorMatrix=pmat)

imp_mice <- mids2datlist(imp_mice)

##############################################################################
# 5. Save
# 5.1 Save imputation
save(imp_mice, file=paste0(workdir,"imputed-mice ",args[1],".RData"))

# 5.2 Calculate Time
end_time <- Sys.time()
time_taken_mice <- end_time - start_time

cat('Using mice, ', m, 'imputations with ', maxit, 'iterations took:', time_taken_mice, attr(time_taken_mice,"units"), ".","\n")

##############################################################################
################################### END ######################################
##############################################################################