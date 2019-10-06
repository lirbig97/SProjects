    # PART 2
    
    library(data.table)
    library(microbenchmark)
    library(Rcpp)
    
    dyn.load('~/Desktop/2019/c_c++/euc_dist.so')
    dyn.load('~/Desktop/2019/c_c++/abdul_code/eucDist.so')
    dyn.load('~/Desktop/2019/c_c++/cDist.so')
    sourceCpp('~/Desktop/2019/c_c++/abdul_code/fastdist.cpp')
    
    # load all R function scripts
    sapply(list.files(path = '~/Desktop/2019/r_scripts/functions', pattern = '[.]R$', full.names = TRUE), 
           FUN = source)
    
    set.seed(1)
    
    grp = sample(1:50, 1000, replace = TRUE)
    M   = matrix(rnorm(2000, mean = 10, sd = 10), ncol = 2)
    M   = cbind(M, grp)


# redirecting output of timings
sink('~/Desktop/2019/per2.txt')


# TIMINGS
#---------------------------------------------------------------------------------
# vectorised calculation of distances between each group, by each FUN

## NOT RUN  

# microbenchmark(by(M, grp, dist),
#                by(M, grp, eucDist),
#                by(M, grp, naive_dist),
#                by(M, grp, r_euc_dist),
#                by(M, grp, cDist),
#                unit = 'microseconds')
#                
#                
               
               
sink(NULL)
#---------------------------------------------------------------------------------
