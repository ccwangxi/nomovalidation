#' External Validation of Cox PH model
#'
#' This function allows you to generate an Uno's C-index of external validation of a Cox PH model.
#' @param TR.data the name of a data frame containing all needed variables, used as training dataset.
#' Need to make sure TR.data and TE.data are in exactly the same structure, i.e. the same variables.
#' @param TE.data the name of a data frame containing all needed variables, used as testing dataset.
#' @param Surv.rsp a Surv object for TR.data. For example, Surv(TR$time_to_death, TR$censor)
#' @param Surv.rsp.new a Surv object for TE.data. For example, Surv(TE$time_to_death, TE$censor)
#' @param times a vector of scalars to specify the timepoints you are interested in for validation.
#' @param formula a formula used to specify a Cox PH model, see cph function.
#' @keywords nomovalidation
#' @importFrom stats predict
#' @author Xi "Ada" Wang
#' @author Ph.D. Student of Biostatistics
#' @author Penn State College of Medicine
#' @author xzw149@@psu.edu
#' @details Returns C.index, the Uno's C-statistic (given by the integral of AUC on [0, max(times)] weighted by the estimated probability density of the time-to-event outcome). see output iauc from survAUC::AUC.uno.
#' @export
#' @examples
#' n <- 500
#' set.seed(2019)
#' var1 <- 30 + 5*rnorm(n)
#' var2 <- factor(sample(c("White","Black"),n,rep=TRUE,prob=c(.3,.7)))
#' hazard <- .1*exp(.2*(var1-30)+.5*(var2=="Black"))
#' time_to_event <- -log(runif(n))/hazard
#' cens <- 15*runif(n)
#' censor <- ifelse(time_to_event <= cens,1,0)
#' All <- data.frame(time_to_event = time_to_event,censor=censor, var1 = var1, var2= var2)
#' TR <- All[1:300,]
#' TE <- All[301:500,]
#' get.external.valid(TR,TE,Surv.rsp=Surv(TR$time_to_event, TR$censor),
#'                    Surv.rsp.new=Surv(TE$time_to_event, TE$censor),
#'                    times=20,formula=Surv(time_to_event,censor) ~ var1 + var2)
#' get.external.valid(TR,TE,Surv.rsp=Surv(TR$time_to_event, TR$censor),
#'                    Surv.rsp.new=Surv(TE$time_to_event, TE$censor),
#'                    times=seq(1,max(TE$time_to_event),1) ,
#'                    formula=Surv(time_to_event,censor) ~ var1 + var2)

get.external.valid <- function(TR.data,TE.data,
                               Surv.rsp, Surv.rsp.new,
                               times,formula){
  train.fit <- rms::cph(formula,TR.data,
                   surv=TRUE,x=TRUE, y=TRUE)
  lpnew <- predict(train.fit, newdata=TE.data)

  AUC_Uno.2 <- AUC.uno(Surv.rsp, Surv.rsp.new, lpnew, times,savesensspec=F)
  C.index <- AUC_Uno.2$iauc

  return(C.index)
}
