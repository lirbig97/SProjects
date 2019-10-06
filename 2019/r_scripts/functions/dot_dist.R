dot_dist <- function(x){
# TODO: function documentation
  result = vector('numeric', length = nrow(x) * (nrow(x) - 1)/2)
  
  i = 1
  m = 1
  while (i <= (nrow(x)-1)){
    for (j in (i+1):nrow(x)){
      k         = x[i, 1:2] - x[j, 1:2]
      result[m] = sqrt(k %*% k)
      m         = m + 1
    }
    i = i + 1
  }
  result
}
