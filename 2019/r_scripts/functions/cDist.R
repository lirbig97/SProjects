# filename: cDist.R
# last edited: 24-JUL-19


# wrapper function for cDist.c
# see cDist.c for function documentation
#
# input: 
#		matrix: an N by 2 numeric matrix
#		cols_interest : if input is a data.frame, the cols to be used.
#
# output: a vector of euclidean distances between the rows of the matrix.
# TODO: error-correcting code



cDist <- function(matrix, cols_interest = c(1,2)){
	cpMat  = matrix[, cols_interest]
    vec    = as.vector(t(cpMat))
    reslen = nrow(cpMat) * (nrow(cpMat) - 1) * 0.5

    .Call("cDist",
           as.double(vec),
           as.double(reslen))
}
