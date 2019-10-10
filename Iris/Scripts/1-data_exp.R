# Last edited: 
# Sun Jun 16 09:41:40 2019 ------------------------------

# DATA EXPLORATION

iris_data = read.csv('Data/Iris.csv')

varNames = names(iris_data)
str(iris_data)
summary(iris_data)

sapply(iris_data, function(x) mean(is.na(x) | is.null(x))) # print missing values

oldPar = par()

par(mfrow = c(2, 2))

for (i in 2:5) {
  hist(iris_data[, i], 
       main = varNames[i], 
       xlab = '',
       col = 'light blue')
  abline(v = mean(iris_data[, i]), lty = 2, col = 'red')
  abline(v = median(iris_data[, i]), lty = 3, col = 'blue')
  
  legend('topright', legend = c('Mean', 'Median'), 
         lty = c(2,3), col = c('red', 'blue'), 
         cex = 0.8)

}
for (i in 2:5) boxplot(iris_data[, i] ~ iris_data$Species, 
                       main = varNames[i],
                       col = 'light blue',
                        pch = 16)

par(oldPar)

pairs(iris_data[, -c(1,6)], 
      col = c('red', 'blue', 'green')[iris_data$Species],
      pch = 16)

iris_data$SpecNum = as.numeric(iris_data$Species) # converting species to numeric to use with cor
round(cor(iris_data[, -c(1,6)]), digits = 3)[5, ]

# Variables to use in models
# "SepalLengthCm" "PetalLengthCm" "PetalWidthCm" 
