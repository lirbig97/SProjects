# Non-linear Model
# Polynomial regression fitting using loess()

nlm <- loess(mpg ~ disp + wt, 
             data = train,
             span = 0.5,
             family = 'sym')


# train RMSE 3.2
# test RMSE  5.2