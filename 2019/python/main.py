#!/usr/bin/python

import numpy as np
from numpy.random import randn
import time
from math import sqrt

size = 1000

k = randn(size)
r  = size / 2



def eucDist(arr, nRows):
	k = 0
	iter1, iter2 = len(arr) - 3, len(arr) - 1
	result = np.zeros((1, int(nRows * (nRows - 1) * 0.5)))

	for i in range(0, iter1, 2):
		for j in range(i+2, iter2, 2):
			result[0][k] = sqrt((arr[i] - arr[j]) * (arr[i] - arr[j])\
						+ (arr[i+1] - arr[j+1]) * (arr[i+1] - arr[j+1]))
			k += 1
	return np.matrix(result)


start = time.time()

eucDist(k, r)

end = time.time()

print(end - start)

