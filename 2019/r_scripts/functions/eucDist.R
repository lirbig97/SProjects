# filename: eucDist.R
# wrapper function for eucDist.c
# TODO: error correcting code

eucDist <- function(matrix, cols_interest = 1:2){
	
	cpMat 	= matrix[, cols_interest]
    len_mat = dim(matrix)[1] * dim(matrix)[2]
    n_rows  = nrow(matrix)
    n_cols  = ncol(matrix)
    vec     = as.vector(t(matrix))

    
    .C('eucDist',
       as.double(vec),
       as.integer(n_rows),
       as.integer(n_cols),
       as.double(vector("double", n_rows * (n_rows - 1)/2))
       )[[4]]
}
