naive_dist <- function(x){

#TODO: function documentation

    result = vector('numeric', length = nrow(x) * (nrow(x) - 1)/2)
    k = 1
    for (i in 1:(nrow(x)-1)){
        for (j in (i+1):nrow(x)){
          result[k] = sqrt((x[i,1]-x[j,1])^2 + (x[i,2] - x[j,2])^2)
          k = k + 1
        }
    }
    result
}



