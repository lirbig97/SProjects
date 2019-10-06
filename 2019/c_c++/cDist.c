/* 
filename: cDist.c
last edited: 24-JUL-19
*/


/*
 exactly as euc_dist.c but modified to use R's .Call() interface

 input:
    Rvec: a one-dimensional array of length N * 2 where N is the number of rows
          in the input matrix.
    
    resLen: an integer (coerced to double) of the number of pairs
            calculated as N * (N - 1)/2.
 output:
    result: a one-dimensional array containing the calculated distances.  
*/

#include <R.h>
#include <Rinternals.h>
#include <math.h>

SEXP cDist(SEXP Rvec, SEXP resLen){
    int k = 0, i, j, iter1 = length(Rvec) - 3, iter2 = length(Rvec) - 1;

    SEXP result = PROTECT(allocVector(REALSXP, asReal(resLen)));
    double *vec = REAL(Rvec);

    for(i = 0; i < iter1; i += 2){
        for(j = i + 2; j < iter2; j += 2){
            REAL(result)[k] = sqrt(((vec[i] - vec[j]) * (vec[i] - vec[j])) + 
                         ((vec[i+1] - vec[j+1]) * (vec[i+1] - vec[j+1])));
            k++;
        }
    }

    UNPROTECT(1);
    return result;
 
}
