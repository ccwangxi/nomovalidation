#' Internal Validation of Cox PH model
#'
#' This function allows you to generate a Harrell's C-index of internal validation for a Cox PH model.
#' @param formula a formula used to specify a Cox PH model, see cph function.
#' @param TR.data the name of a data frame containing all needed variables, used as training dataset.
#' @param B.num a number of repetitions for bootstrap. Defaults to 150
#' @param seed a single value, interpreted as an integer, or NULL
#' @keywords nomovalidation
#' @import rms
#' @details Returns C.index, a value of Harrell's C-index. C index is calculated from Dxy.
#' @details The relation between Dxy and C-index is Dxy=2*(C-0.5).
#' @author Xi "Ada" Wang
#' @author Ph.D. Student of Biostatistics
#' @author Penn State College of Medicine
#' @author xzw149@@psu.edu
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
#' TR <- data.frame(time_to_event = time_to_event,censor=censor, var1 = var1, var2= var2)
#' get.internal.valid(formula = Surv(time_to_event,censor) ~ var1 + var2,TR,B.num=2)

get.internal.valid <- function(formula,TR.data,
                               B.num=200,seed=2019){
  valid.cox <- rms::cph(formula,TR.data,
                   surv=TRUE,x=TRUE, y=TRUE, time.inc=0.5)
  valid <- rms::validate(valid.cox, method="boot", dxy=TRUE, B=B.num)
  Dxy <- valid["Dxy","index.corrected"]
  C.index = 0.5 + Dxy/2
  return(C.index)
}
