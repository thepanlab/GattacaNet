require(bWGR)
data(tpod)
length(gen)

require(snpStats)
require(bWGR)
require(rrBLUP)
require(pedigree)
library(pROC)

##Data path

bim="/work/breastcancer/clean_test/train/sig0.001.bim"
fam="/work/breastcancer/clean_test/train/sig0.001.fam"
bed="/work/breastcancer/clean_test/train/sig0.001.bed"
bim2="/work/breastcancer/clean_test/validation/val0.001.bim"
fam2="/work/breastcancer/clean_test/validation/val0.001.fam"
bed2="/work/breastcancer/clean_test/validation/val0.001.bed"
bim3="/work/breastcancer/clean_test/test/test0.001.bim"
fam3="/work/breastcancer/clean_test/test/test0.001.fam"
bed3="/work/breastcancer/clean_test/test/test0.001.bed"
print("Load Data")
out=read.plink(bed,bim,fam)
out2=read.plink(bed2,bim2,fam2)
out3=read.plink(bed3,bim3,fam3)

x=as.data.frame(as(out$genotypes, class(numeric())))
xval=as.data.frame(as(out2$genotypes, class(numeric())))
xtest=as.data.frame(as(out3$genotypes, class(numeric())))
print("data Loaded")
x[is.na(x)]<-2
xval[is.na(xval)]<-2
xtest[is.na(xtest)]<-2

print("NA filled")

xtrain=as.matrix(x)
ytrain=out$fam$affected-1
xval=as.matrix(xval)
yval=out2$fam$affected-1
xtest=as.matrix(xtest)
ytest=out3$fam$affected-1
x_train=t(t(xtrain))
print("Fitting...")

## Function that output scores
score_func<-function(m,yval,xval,ytest,xtest){
  pred=xval%*%as.matrix(m$b)+m$mu
  predtest=xtest%*%as.matrix(m$b)+m$mu
  roc_obj=roc(yval,as.vector(pred))
  print(paste("Validation:",roc_obj$auc))
  roc_objtest=roc(ytest,as.vector(predtest))
  print(paste("Test:",roc_objtest$auc))
  print("Done")
  return(roc_obj$test)
}


sizes=c(10000,20000,30000,39289)
scores_tot=list()
print(dim(x_train))
for(i in sizes){
  print(i)
  scores=list()
  # BLUP
  fit_BRR = wgr(ytrain[0:i],x_train[0:i,],iv=FALSE,pi=0)
  scores=append(scores,score_func(fit_BRR,yval,xval,ytest,xtest))
  # BayesA
  fit_BayesA = wgr(ytrain[0:i],x_train[0:i,],iv=TRUE,pi=0)
  scores=append(scores,score_func(fit_BayesA,yval,xval,ytest,xtest))
  if(i<10000){
    # BayesB (give inf)
    fit_BayesB = wgr(ytrain[0:i],x_train[0:i,],iv=TRUE,pi=.95)
    scores=append(scores,score_func(fit_BayesB,yval,xval,ytest,xtest))
    # BayesC ( get inf)
    fit_BayesC = wgr(ytrain[0:i],x_train[0:i,],iv=FALSE,pi=0.95)
    scores=append(scores,score_func(fit_BayesC,yval,xval,ytest,xtest))
  }
  else{
    
    scores=append(scores,-1)
    scores=append(scores,-1)
  }
  
  # BayesCpi
  fit_BayesCpi = BayesCpi(ytrain[0:i],x_train[0:i,])
  scores=append(scores,score_func(fit_BayesCpi,yval,xval,ytest,xtest))
  # BayesDpi
  fit_BayesDpi = BayesDpi(ytrain[0:i],x_train[0:i,])
  scores=append(scores,score_func(fit_BayesDpi,yval,xval,ytest,xtest))
  # BayesL
  fit_BayesL = wgr(ytrain[0:i],x_train[0:i,],de=TRUE)
  scores=append(scores,score_func(fit_BayesL,yval,xval,ytest,xtest))
  # Bagging BLUP
  fit_Bag = wgr(ytrain[0:i],x_train[0:i,],bag=0.5)
  scores=append(scores,score_func(fit_Bag,yval,xval,ytest,xtest))
  scores_tot=append(scores_tot,list(scores))
}


