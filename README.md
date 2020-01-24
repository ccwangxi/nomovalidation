# Introduction of nomovalidation
nomovalidation is an R package for measure the prediction performance of a Cox PH model by internal calibration, internal validation, and external validation. This package was built on the R packages rms and survAUC. 
"nomo" in the package name comes from nomogram, which is a visualization of a Cox PH model. 
Physicians and clinicians use nomogram to quickly judge the survival of a patient based on the covariables (age, race, etc).  
Before using this package, a Cox PH model need to be developed using the training dataset. This package contains 3 R functions:
    
   #### 1. get_internal_calibrarion.R: 
   To investigate the predictive performance of the Cox PH model at a specific value of time-to-event you are interested in, a calibration plot will be generated.
   #### 2. get_internal_validation.R: 
   To assess the performance of the developed Cox PH model by bootstraping the training dataset, Harrell's C-index will be calculated for internal validation. 
   #### 3. get_external_validation.R: 
   To further assess the performance of the developed Cox PH model by applying it to an independent testing dataset, Uno's C-index will be calculated for external validation.

# Installation in R
### 1. Install R packages rms and survAUC
    install.packages("rms")
    install.packages("survAUC")
### 2. Install R package nomovalidation
    install.packages("devtools")
    library(devtools)
    install_github("ccwangxi/nomovalidation")
