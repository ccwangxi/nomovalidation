# Introduction of nomovalidation
nomovalidation is an R package for measure the prediction performance of a Cox PH model by internal calibration, internal validation, and external validation. This package was built on the R packages rms and survAUC. 
"nomo" in the package name comes from nomogram, which is a visualization of a Cox PH model. 
Physicians and clinicians use nomogram to quickly judge the survival of a patient based on the covariables (age, race, etc).  
Before using this package, a Cox PH model need to be developed using the training dataset. This package contains 3 R functions:
    
    get_internal_calibrarion.R: For a specific value of time to event you are interested in to investigate the predictive performance of the Cox PH model, a calibration plot will be generated.
    get_external_validation.R: Harrell's C-index will be calculated for internal validation in training dataset. 
    get_internal_validation.R: Performing the Cox PH model using the testing dataset, Uno's C-index will be calculated for external validation.

# Installation in R
## 1. Install R packages rms and survAUC
install.packages("rms")
install.packages("survAUC")
## 2. Install R package nomovalidation
install.packages("devtools")
library(devtools)
install_github("ccwangxi/nomovalidation")
