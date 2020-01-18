# nomovalidation
A R Package for internal calibration, internal validation, and external validation of a Cox PH model. This package was built on the R packages rms and survAUC. 
"nomo" in the package name comes from nomogram, which is a visualization of a Cox PH model. 
Physicians and clinicians use nomogram to quickly judg the survival of a patient based on the covariables (age, race, and etc).  
Before using this package, a cox PH model need to be developed using a training dataset. 
    Harrell's C-index will be calculated for internal validation in training dataset. 
    Performing the Cox PH model using testing dataset, Uno's C-index will be calculated for external validation.

# installation in R
## Need to install R packages rms and survAUC first
install.packages("rms")
install.packages("survAUC")
## The install R package nomovalidation
install.packages("devtools")
library(devtools)
install_github("ccwangxi/nomovalidation")
