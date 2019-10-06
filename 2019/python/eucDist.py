import numpy as np
from math import sqrt

def eucDist(arr, nRows):
	k = 0
	iter1, iter2 = len(arr) - 3, len(arr) - 1
	result = np.zeros((1, nRows * (nRows - 1) * 0.5))

	for i in range(iter1):
		for j in range(i+2, iter2):
			result[k] = sqrt((arr[i] - arr[j]) * (arr[i] - arr[j])\
						+ (arr[i+1] - arr[j+1]) * (arr[i+1] - arr[j+1]))
			k += 1
	return result
			
		
	
