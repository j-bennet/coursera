import time

def sum_of_two(h, sums):
    x = time.time()
    is_sum = ['0' for i in sums]
    for i in range(len(sums)):
        for k in h.iterkeys():
            if sums[i] - k in h:
                is_sum[i] = '1'
                break
    print 'Calculated %d sums in %d' % (len(sums), time.time() - x)
    return ''.join(is_sum)

def read_hash(fname):
    h = {}
    f = open(fname, 'r')
    for line in f:
        h[int(line.strip())] = 1
    return h

x = time.time()
h = read_hash('./HashInt.txt')
print 'Read %d values in %d' % (len(h), time.time() - x)

print sum_of_two(h, [231552,234756,596873,648219,726312,981237,988331,1277361,1283379])