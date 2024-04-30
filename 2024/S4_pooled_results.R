######################################################################################
##   
## Random Intercept Cross-Lagged Panel Model of Physical Activity and Loneliness
## Data finalise and code
## Date: 5 August 2022
##
######################################################################################
# 1. Setup Environment
#-------------------------------------------------------------------------------------

.libPaths("D:/Dropbox (Sydney Uni)/R Library Windows")
workdir <- "D:/Dropbox (Sydney Uni)/HRS/Paper 2 - Bidirectional analysis/"

libs <- c("lavaan","haven","Amelia","matlib")
missing <- !libs %in% installed.packages()
if (any(missing)) {
  install.packages(libs[missing])
}
require(lavaan)
require(haven)
require(Amelia)

##############################################################################
# 2. Load lavaan model fit lists
#-----------------------------------------------------------------------------

load(paste0(workdir,"Results/Unadjusted model fits.RData"))
load(paste0(workdir,"Results/Partially adjusted model fits.RData"))
load(paste0(workdir,"Results/Fully adjusted model fits.RData"))

##############################################################################
# 3. Pool results using Amelia
#-----------------------------------------------------------------------------

# 3.1 Unadjusted models
# 3.1.1 Regression
unadj_res_co <- do.call(rbind, lapply(RICLPMunadj.fit, function (x) {
  as.vector(t(lavInspect(x,"est")$beta[c("wlonely2","wvigpa_bin2","wmodpa_bin2"),c("wlonely1","wvigpa_bin1","wmodpa_bin1")]))
}))
unadj_res_se <- do.call(rbind, lapply(RICLPMunadj.fit, function (x) {
  as.vector(t(lavInspect(x,"se")$beta[c("wlonely2","wvigpa_bin2","wmodpa_bin2"),c("wlonely1","wvigpa_bin1","wmodpa_bin1")]))
}))
unadj_res <- t(do.call(rbind, mi.meld(q=unadj_res_co,se=unadj_res_se)))
unadj_res <- cbind(unadj_res[1:3,1:2],unadj_res[4:6,1:2],unadj_res[7:9,1:2])
rownames(unadj_res) <- c("lonely","vigorous","moderate")
colnames(unadj_res) <- c("lonely co","lonely se","vigorous co","vigorous se","moderate co","moderate se")

# 3.1.2 Covariance
unadj_cov_co <- do.call(rbind, lapply(RICLPMunadj.fit, function (x) {
  c(summary(x)$pe[which(summary(x)$pe$label=="er4"),][1,6],
    summary(x)$pe[which(summary(x)$pe$label=="er5"),][1,6],
    summary(x)$pe[which(summary(x)$pe$label=="er6"),][1,6])
}))
unadj_cov_se <- do.call(rbind, lapply(RICLPMunadj.fit, function (x) {
  c(summary(x)$pe[which(summary(x)$pe$label=="er4"),][1,7],
    summary(x)$pe[which(summary(x)$pe$label=="er5"),][1,7],
    summary(x)$pe[which(summary(x)$pe$label=="er6"),][1,7])
}))
unadj_cov <- t(do.call(rbind, mi.meld(q=unadj_cov_co,se=unadj_cov_se)))
rownames(unadj_cov) <- c("lonely-vigorous","lonely-moderate","Vigorous-moderate")
colnames(unadj_cov) <- c("cov","se")

# 3.2 Partially adjusted models
# 3.2.1 Regression
partial_res_co <- do.call(rbind, lapply(RICLPMpartial.fit, function (x) {
  as.vector(t(lavInspect(x,"est")$beta[c("wlonely2","wvigpa_bin2","wmodpa_bin2"),c("wlonely1","wvigpa_bin1","wmodpa_bin1")]))
}))
partial_res_se <- do.call(rbind, lapply(RICLPMpartial.fit, function (x) {
  as.vector(t(lavInspect(x,"se")$beta[c("wlonely2","wvigpa_bin2","wmodpa_bin2"),c("wlonely1","wvigpa_bin1","wmodpa_bin1")]))
}))
partial_res <- t(do.call(rbind, mi.meld(q=partial_res_co,se=partial_res_se)))
partial_res <- cbind(partial_res[1:3,1:2],partial_res[4:6,1:2],partial_res[7:9,1:2])
rownames(partial_res) <- c("lonely","vigorous","moderate")
colnames(partial_res) <- c("lonely co","lonely se","vigorous co","vigorous se","moderate co","moderate se")

# 3.2.2 Covariance
partial_cov_co <- do.call(rbind, lapply(RICLPMpartial.fit, function (x) {
  c(summary(x)$pe[which(summary(x)$pe$label=="er4"),][1,6],
    summary(x)$pe[which(summary(x)$pe$label=="er5"),][1,6],
    summary(x)$pe[which(summary(x)$pe$label=="er6"),][1,6])
}))
partial_cov_se <- do.call(rbind, lapply(RICLPMpartial.fit, function (x) {
  c(summary(x)$pe[which(summary(x)$pe$label=="er4"),][1,7],
    summary(x)$pe[which(summary(x)$pe$label=="er5"),][1,7],
    summary(x)$pe[which(summary(x)$pe$label=="er6"),][1,7])
}))
partial_cov <- t(do.call(rbind, mi.meld(q=partial_cov_co,se=partial_cov_se)))
rownames(partial_cov) <- c("lonely-vigorous","lonely-moderate","Vigorous-moderate")
colnames(partial_cov) <- c("cov","se")

# 3.3 Fully adjusted models
# 3.3.1 Regression
fully_res_co <- do.call(rbind, lapply(RICLPMfully.fit, function (x) {
  as.vector(t(lavInspect(x,"est")$beta[c("wlonely2","wvigpa_bin2","wmodpa_bin2"),c("wlonely1","wvigpa_bin1","wmodpa_bin1")]))
}))
fully_res_se <- do.call(rbind, lapply(RICLPMfully.fit, function (x) {
  as.vector(t(lavInspect(x,"se")$beta[c("wlonely2","wvigpa_bin2","wmodpa_bin2"),c("wlonely1","wvigpa_bin1","wmodpa_bin1")]))
}))
fully_res <- t(do.call(rbind, mi.meld(q=fully_res_co,se=fully_res_se)))
fully_res <- cbind(fully_res[1:3,1:2],fully_res[4:6,1:2],fully_res[7:9,1:2])
rownames(fully_res) <- c("lonely","vigorous","moderate")
colnames(fully_res) <- c("lonely co","lonely se","vigorous co","vigorous se","moderate co","moderate se")

# 3.3.2 Covariance
fully_cov_co <- do.call(rbind, lapply(RICLPMfully.fit, function (x) {
  c(summary(x)$pe[which(summary(x)$pe$label=="er4"),][1,6],
    summary(x)$pe[which(summary(x)$pe$label=="er5"),][1,6],
    summary(x)$pe[which(summary(x)$pe$label=="er6"),][1,6])
}))
fully_cov_se <- do.call(rbind, lapply(RICLPMfully.fit, function (x) {
  c(summary(x)$pe[which(summary(x)$pe$label=="er4"),][1,7],
    summary(x)$pe[which(summary(x)$pe$label=="er5"),][1,7],
    summary(x)$pe[which(summary(x)$pe$label=="er6"),][1,7])
}))
fully_cov <- t(do.call(rbind, mi.meld(q=fully_cov_co,se=fully_cov_se)))
rownames(fully_cov) <- c("lonely-vigorous","lonely-moderate","Vigorous-moderate")
colnames(fully_cov) <- c("cov","se")

##############################################################################
# 4. Save results to CSV
#-----------------------------------------------------------------------------

write.csv(unadj_res,file=paste0(workdir,"Results/Unadjusted regression results.csv"))
write.csv(unadj_cov,file=paste0(workdir,"Results/Unadjusted covariance results.csv"))

write.csv(partial_res,file=paste0(workdir,"Results/Partially adjusted regression results.csv"))
write.csv(partial_cov,file=paste0(workdir,"Results/Partially adjusted covariance results.csv"))

write.csv(fully_res,file=paste0(workdir,"Results/Fully adjusted regression results.csv"))
write.csv(fully_cov,file=paste0(workdir,"Results/Fully adjusted covariance results.csv"))