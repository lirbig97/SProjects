# filename: r_euc_dist.R
# last edited: 5-JUL-2019


r_euc_dist <- function(matrix, cols_interest = 1:2){

# R wrapper function for euc_dist.c
# check euc_dist.c for source code and function documentation
# input: 
#		matrix: an N by 2 numeric matrix
#		cols_interest : if input is a data.frame, the cols to be used.
		 
# output: a vector of euclidean distances between rows
	cpMat   = matrix[, cols_interest]
	len_mat = dim(cpMat)[1] * dim(cpMat)[2]
    n_rows  = nrow(cpMat)
    vec     = as.vector(t(cpMat))

    .C("euc_dist",
        as.double(vec),
        as.integer(len_mat),
        as.double(vector("double", n_rows * (n_rows - 1)/2)))[[3]]

    }
