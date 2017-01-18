def merge_sort_count(a):
	if len(a) <= 1: return a, 0
	
	m = (len(a) - 1) / 2
	l, x = merge_sort_count(a[:m + 1])
	r, y = merge_sort_count(a[m + 1:])
	a, z = merge_count(l, r)
	return a, x + y + z

def merge_count(l, r):
	t = []
	i = 0
	j = 0
	cnt = 0
	while i < len(l) or j < len(r):
		if i < len(l) and j < len(r):
			if l[i] < r[j]:
				t.append(l[i])
				i += 1
			else:
				t.append(r[j])
				cnt += len(l) - i
				j += 1
		else:
			if i < len(l):
				t.append(l[i])
				i += 1
			else:
				t.append(r[j])
				j += 1
	return t, cnt

data = []
f = open('./IntegerArray.txt', 'r')
for line in f:
	data.append(int(line))

data, n = merge_sort_count(data)

print 'Count: ' + str(n)