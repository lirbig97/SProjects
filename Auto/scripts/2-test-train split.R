# 70-30 test train split
# last edited:
# Mon Jul 01 17:02:03 2019 ------------------------------
  

set.seed(1)

train = sample(nrow(auto.data), 0.7 * nrow(auto.data))

train.data = auto.data[train, ]

test.data = auto.data[-train, ]

write.csv(train.data, file = 'Data/processed/train.csv')
write.csv(test.data, file = 'Data/processed/test.csv')

