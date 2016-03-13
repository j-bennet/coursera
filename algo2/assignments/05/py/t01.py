n = 25

#a = [[sys.maxint for j in range(n)] for i in range(2**n)]
from numpy import *
import sys

a = zeros((2**n, n), int)

print len(a[0])
print len(a)