#fin = open("t3-1.txt", "r")
fin = open("edges.txt", "r")

line = fin.readline().strip()
n, m = map(int, line.split(' ', 2))

g = {}

for e in range(m):
    line = fin.readline().strip()
    v, w, c = map(int, line.split(' ', 3))
    
    g.setdefault(v, [])
    g.setdefault(w, [])
    g[v].append((w, c))
    g[w].append((v, c))

fin.close()

#print g

def cheapest(g, x):
	min_v = None
	min_w = None
	min_c = None
	for v in x:
		for (w, c) in g[v]:
			if (w not in x):
				#print '\t Considering:', (v, w), c
				if (min_c == None or min_c > c):
					min_c = c
					min_w = w
					min_v = v
	return min_v, min_w, min_c

k = g.keys()
x = set([])
x.add(k[0])
total = 0

while len(x) < len(k):
	v, w, c = cheapest(g, x)
	x.add(w)
	total += c
	#print 'Add', (v, w), c, ':', total

print 'Total:', total