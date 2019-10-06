// filename: fastdist2.cpp

#include <Rcpp.h>
using namespace Rcpp;

//[[Rcpp::export]]

NumericVector fastdist2 (const NumericMatrix &x){
	unsigned int outrows = x.nrow(), i = 0, j = 0, k = 0;

	Rcpp::NumericVector out(outrows * (outrows - 1)/2);

	for (i = 0; i <= outrows - 2; i++){
		for (j = i+1; j <= outrows - 1; j++){

			out(k) = sqrt(sum(pow(x.row(i) - x.row(j), 2.0)));
					k++;
}
	}
	return out;
}
