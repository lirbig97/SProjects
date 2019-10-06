/*
filename: euc_dist.c
last edited: 23-JUL-2019
*/


#include <R.h>
#include <math.h>

/*
Calculates the euclidean distance between rows of a matrix

input: 
    vec: a one dimensional array of length N * 2 where N is the number of rows
       in the input matrix.
    len_vec: N * 2
output:
    result: a one dimensional array of length N * 2 containing the calculated distances 
*/

void euc_dist(double *vec, int *len_vec, double *result)
{
    int k = 0, i, j, iter1 = *len_vec - 3, iter2 = *len_vec - 1;

    for (i = 0; i < iter1; i += 2){
        for (j = i + 2; j < iter2; j += 2){
            result[k] = sqrt((vec[i] - vec[j]) * (vec[i] - vec[j]) 
						+ (vec[i+1] - vec[j+1]) * (vec[i+1] - vec[j+1]));
            k++;
        }
      }

}
