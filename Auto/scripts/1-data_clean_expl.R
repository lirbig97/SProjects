# last edited:
# Sun Jun 16 09:51:24 2019 ------------------------------

# Data exploration & cleaning

auto_dat = read.table(file = '../Auto/Data/raw/auto-mpg.data', na.strings = "?")

varNames = c('mpg', 'cylinders', 'disp', 'hp', 'wt', 'accl', 'model_yr', 'origin', 'name')

str(auto_dat)
names(auto_dat) = varNames
summary(auto_dat)

# coding discrete attributes as factors

for (i in c(2, 7, 8)) auto_dat[, i] = as.factor(auto_dat[, i])

# proportion of missing values for each var
sapply(auto_dat, function(x) signif(mean(is.na(x) | is.null(x)), 3))

hist(auto_dat$hp)
# replace missing values in hp with median value
auto_dat$hp[is.na(auto_dat$hp)] = median(auto_dat$hp, na.rm = TRUE)

hist(auto_dat$hp) # distribution unchanged!

# create new variable `manuc` to be makers of a car model

auto_dat$manuc = gsub("( .*)", '', auto_dat$name) # extract maker names from name var
table(auto_dat$manuc)  

# using fuzzy matching to remove duplicates with wrong spelling
auto_dat$manuc[agrep("chev", auto_dat$manuc)] = 'chevrolet'
auto_dat$manuc[agrep("toyota", auto_dat$manuc)] = 'toyota'
auto_dat$manuc[agrep("mazda", auto_dat$manuc)] = 'mazda'
auto_dat$manuc[agrep("mercedes", auto_dat$manuc)] = 'mercedes'
auto_dat$manuc[agrep("volswagen", auto_dat$manuc)] = 'volkswagen'
auto_dat$manuc [auto_dat$manuc == 'vw'] = 'volkswagen'

table(auto_dat$manuc)
auto_dat = auto_dat[, -9]
cor(auto_dat[, c(1, 3:6)])

# store cleaned file
write.csv(auto_dat, file = '../Auto/Data/processed/auto.csv', row.names = FALSE)

