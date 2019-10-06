library(Rcpp)
library(microbenchmark)

sapply(list.files(path = '~/Desktop/2019/r_scripts/functions', 
                  pattern = '[.]R$', 
                  full.names = TRUE),
        FUN = source)

set.seed(1)

sourceCpp('~/Desktop/2019/c_c++/abdul_code/fastdist.cpp')
dyn.load('~/Desktop/2019/c_c++/euc_dist.so')
dyn.load('~/Desktop/2019/c_c++/cDist.so')
dyn.load('~/Desktop/2019/c_c++/abdul_code/eucDist.so')



sink('~/Desktop/2019/times.txt')

for (k in c(10, 100, 1000, 10000)){


m = matrix(rnorm(k, mean = 10, sd = 10), ncol = 2)
print(microbenchmark(dist(m),
               dot_dist(m),
               naive_dist(m),
               r_euc_dist(m),
               eucDist(m),
               fastdist2(m),
               cDist(m), times = 50, unit = 'ms'))

}

sink(NULL)
