#' Internal Calibration of Cox PH model
#'
#' This function allows you to generate an internal calibration plot of a Cox PH model.
#' @param formula a formula used to specify a Cox PH model, see cph function.
#' @param TR.data the name of a data frame containing all needed variables, used as training dataset.
#' @param time a single value to specify the timepoint you are interested in for calibration.
#' @param fig.name a string for the name of the calibration plot.
#' @param quality the ‘quality’ of the JPEG image, as a percentage. Smaller values will give more compression but also more degradation of the image. Defaults to 300
#' @param res The nominal resolution in ppi which will be recorded in the bitmap file, is a positive integer. Defaults to 100
#' @param fig.title a string for the title of the figure
#' @param fig.width a number of width of the calibration plot. Defaults to 800
#' @param fig.height a number of height of the calibration plot. Defaults to 700
#' @param B.num a number of repetitions for bootstrap. Defaults to 150
#' @param seed a single value, interpreted as an integer, or NULL
#' @keywords nomovalidation
#' @importFrom grDevices dev.off jpeg
#' @importFrom graphics plot
#' @details For other parameters in rms::calibrate, use default setting.
#' @details In cph function, surv=TRUE and time.inc=u were specified to make a calibration plot.
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
#' get.internal.cal(formula = Surv(time_to_event,censor) ~ var1 + var2,
#'                   TR.data = TR,time = 12,fig.name="name", fig.title='Survival_Plot')

get.internal.cal <- function(formula,TR.data,time,
                              fig.name,fig.title,
                              fig.width=800,fig.height=700,quality=300,res=100,
                              B.num=150,seed=2019){
  mod.cox <- rms::cph(formula,TR.data,
                 surv=TRUE,x=TRUE, y=TRUE, time.inc=time)
  set.seed(seed)
  cal <- rms::calibrate(mod.cox,u=time,B=B.num,add=TRUE)
  jpeg(paste0(fig.name,".jpeg"),width=fig.width,height=fig.height,quality=quality,res=res)
  plot(cal,xlim=c(0,1),ylim=c(0,1),main=fig.title)
  dev.off()
}
