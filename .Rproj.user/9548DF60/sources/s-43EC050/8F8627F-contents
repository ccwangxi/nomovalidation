n <- 500
set.seed(2019)
var1 <- 30 + 5*rnorm(n)
var2 <- factor(sample(c("White","Black"),n,rep=TRUE,prob=c(.3,.7)))
hazard <- .1*exp(.2*(var1-30)+.5*(var2=="Black"))
time_to_event <- -log(runif(n))/hazard
cens <- 15*runif(n)
censor <- ifelse(time_to_event <= cens,1,0)
TR <- data.frame(time_to_event = time_to_event,censor=censor, var1 = var1, var2= var2)

get.internal.cal(formula = Surv(time_to_event,censor) ~ var1 + var2,
                 TR.data = TR,time = 12,fig.name="name", fig.title='Survival_Plot')

get.internal.valid(formula = Surv(time_to_event,censor) ~ var1 + var2,TR,B.num=2)


All <- data.frame(time_to_event = time_to_event,censor=censor, var1 = var1, var2= var2)
TR <- All[1:300,]
TE <- All[301:500,]
get.external.valid(TR,TE,Surv.rsp=Surv(TR$time_to_event, TR$censor),
                   Surv.rsp.new=Surv(TE$time_to_event, TE$censor),
                   times=20,formula=Surv(time_to_event,censor) ~ var1 + var2)
get.external.valid(TR,TE,Surv.rsp=Surv(TR$time_to_event, TR$censor),
                   Surv.rsp.new=Surv(TE$time_to_event, TE$censor),
                   times=seq(1,max(TE$time_to_event),1) ,
                   formula=Surv(time_to_event,censor) ~ var1 + var2)
