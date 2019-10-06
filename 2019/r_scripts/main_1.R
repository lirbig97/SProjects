# PART 1

library(microbenchmark)
library(Rcpp)

set.seed(1)

sourceCpp('~/Desktop/2019/c_c++/abdul_code/fastdist.cpp')

dyn.load('~/Desktop/2019/c_c++/euc_dist.so')
dyn.load('~/Desktop/2019/c_c++/abdul_code/eucDist.so')

source('~/Desktop/2019/r_scripts/functions/r_euc_dist.R')
source('~/Desktop/2019/r_scripts/functions/dot_dist.R')
source('~/Desktop/2019/r_scripts/functions/naive_dist.R')
source('~/Desktop/2019/r_scripts/functions/eucDist.R')


M = matrix(rnorm(2000, mean = 10, sd = 10), ncol = 2)



microbenchmark(naive_dist(M), 
               dist(M),
               r_euc_dist(M),
               dot_dist(M),
              fastdist2(M),
              eucDist(M),
              times = 50)

# Unit: milliseconds
# expr        min         lq       mean     median         uq        max neval
# naive_dist(M) 108.764844 112.345827 159.614204 123.644872 180.997800  722.87491   100
# dist(M)   2.359189   2.414288   6.421091   2.553879   4.737312  106.67381   100
# r_euc_dist(M)   2.452377   2.552320   6.355885   2.940078   5.437862   56.91540   100
# dot_dist(M) 635.779005 801.648014 913.272764 869.732299 966.455791 1765.68518   100
# fastdist2(M)   5.546501   5.710764   9.966093   5.963607   8.675815   64.15795   100
# eucDist(M)   2.471523   2.531356   4.934788   2.615671   4.011350   81.44068   100


dyn.unload('~/Desktop/2019/abdul/C_C++/euc_dist.so')
dyn.unload('~/Desktop/2019/c_c++/abdul_code/eucDist.so')
