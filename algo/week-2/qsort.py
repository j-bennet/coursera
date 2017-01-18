total = 0

def qsort_first(a, l, r):
    if l >= r:
        return

    p = partition(a, l, r)
    
    global total
    total += (p - 1) - l + 1
    total += r - (p + 1) + 1
    
    qsort_first(a, l, p - 1)
    qsort_first(a, p + 1, r)

def qsort_med(a, l, r):
    if l >= r:
        return

    mid = l + ((r - l) / 2);
    tmp = [[a[l], l], [a[mid], mid], [a[r], r]]
    tmp.sort()
    med = tmp[1][1]
    
    a[l], a[med] = a[med], a[l]

    p = partition(a, l, r)
    
    global total
    total += (p - 1) - l + 1
    total += r - (p + 1) + 1
    
    qsort_med(a, l, p - 1)
    qsort_med(a, p + 1, r)

def qsort_last(a, l, r):
    if l >= r:
        return

    a[l], a[r] = a[r], a[l]
    p = partition(a, l, r)
    
    global total
    total += (p - 1) - l + 1
    total += r - (p + 1) + 1
    
    qsort_last(a, l, p - 1)
    qsort_last(a, p + 1, r)

def partition(a, l, r):
    pi = a[l]
    i = l + 1
    for j in range(l + 1, r + 1):
        if a[j] < pi:
            a[j], a[i] = a[i], a[j]
            i += 1
    a[l], a[i - 1] = a[i - 1], a[l]
    return i - 1

def read_data(fname):
    d = []
    f = open(fname, 'r')
    for line in f:
        d.append(int(line))
    return d

cases = './QuickSort.txt'

total = 0
data = read_data(cases)
qsort_first(data, 0, len(data) - 1)
print total

total = 0
data = read_data(cases)
qsort_last(data, 0, len(data) - 1)
print total

total = 0
data = read_data(cases)
qsort_med(data, 0, len(data) - 1)
print total
