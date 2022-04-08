#QIC and CIC functions and simulation
#Hin & Wang (2009) for CIC, Pan (2001) for QIC
library(multgee)

#QIC adjusted for Poisson distribution(originally from repolr + geepack)
QIC_forordLORgee_poisson = function (object, digits = 3)
{
  mod.indepen = update(object, LORstr = "independence")
  #qlike = object$ylog(object$fitted.values/(1-object$fitted.values)) + 1log(1 - object$fitted.values)
  qlike = sum((object$y*log(object$fitted.values)) - object$fitted.values)
  QICu = -2 * sum(qlike) + 2 * length(object$coefficients)
  QIC = -2 * sum(qlike) + 2 * sum(diag(solve(mod.indepen$naive.variance) %%
                                         object$robust.variance))
  list(QLike = round(sum(qlike), digits = digits), QIC = round(QIC,
                                                               digits = digits), QICu = round(QICu, digits = digits))
}

#CIC function
CIC_forordLORgee = function (object, digits = 3)
{
  mod.indepen = update(object, LORstr = "independence")
  CIC = sum(diag(solve(mod.indepen$naive.variance) %*%  object$robust.variance))
  list(CIC = round(CIC, digits = digits))
}

#Simulation
#Generating compound symmetry structure data
library(simstudy)
set.seed(71)
sim_cor_poisson = genCorGen(1000, nvars = 4, params1 = 1,
                            dist = "poisson", rho = .7, corstr="cs") #poisson
sim_cor_y = rnorm(1000, 0, 1)
sim_poisson = cbind(sim_cor_poisson, sim_cor_y)

#Poisson simulation
colnames(sim_poisson) = c("id", "time", "y", "x")
sim_poisson_gee.0 = ordLORgee(y ~ x, data=sim_poisson, link = "logit", id = id,
                              LORstr = "independence", repeated = time)
sim_poisson_gee.1 = ordLORgee(y ~ x, data=sim_poisson, link = "logit", id = id,
                              LORstr = "uniform", repeated = time)
sim_poisson_gee.2 = ordLORgee(y ~ x, data=sim_poisson, link = "logit", id = id,
                              LORstr = "category.exch", repeated = time)
sim_poisson_gee.3 = ordLORgee(y ~ x, data=sim_poisson, link = "logit", id = id,
                              LORstr = "time.exch", repeated = time)

summary(sim_poisson_gee.0)
summary(sim_poisson_gee.1)
summary(sim_poisson_gee.2)
summary(sim_poisson_gee.3)

QIC_forordLORgee_poisson(sim_poisson_gee.0) #independence
QIC_forordLORgee_poisson(sim_poisson_gee.1) #uniform
QIC_forordLORgee_poisson(sim_poisson_gee.2) #category-exchangeable
QIC_forordLORgee_poisson(sim_poisson_gee.3) #time-exchangeable

CIC_forordLORgee(sim_poisson_gee.0) #independence
CIC_forordLORgee(sim_poisson_gee.1) #uniform
CIC_forordLORgee(sim_poisson_gee.2) #category-exchangeable
CIC_forordLORgee(sim_poisson_gee.3) #time-exchangeable