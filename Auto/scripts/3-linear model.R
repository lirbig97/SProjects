# Linear model

train <- read.csv('../Auto/Data/processed/train.csv')
train <- train[, -1]

str(train)
names(train)

for (i in c(2, 7, 8)) train[, i] = as.factor(train[, i])


sapply(train, function(x) sum(is.na(x) | is.null(x)))

pairs(train)

lm_best = with(train, lm(mpg ~ I(1/disp)
                         + I(1/hp) 
                         + cylinders
                         + accl
                         + wt))

summary(lm_best)

saveRDS(lm_best, file = '../Auto/models/linearModel.rds')

# train RMSE 3.66
# test RMSE 4.27
