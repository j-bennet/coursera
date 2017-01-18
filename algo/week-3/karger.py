import random, copy, math

def karger(g):
    while (len(g)) > 2:
        v, u = random_edge(g)
        contract(g, v, u)
#        for k, a in g.iteritems():
#            print k, '=>', a
    return len(g[g.keys()[0]])

def contract(g, v, u):
    # add u's list to v
    for item in g[u]:
        g[v].append(item)
    
    # point neighbours of u to v instead
    for i in range(0, len(g[u])):
        n = g[u][i]
        for j in range(0, len(g[n])):
            if g[n][j] == u:
                g[n][j] = v

    # remove self-loops in v's list
    for i in range(len(g[v]) - 1, -1, -1):
        if g[v][i] == v:
            g[v].pop(i)
    
    # remove u
    g.pop(u)
    
def random_edge(g):
    v = g.keys()[random.randint(0, len(g) - 1)]        
    u = g[v][random.randint(0, len(g[v]) - 1)]
    return v, u

def parse_data(data):
    g = {}
    for line in data:
        v = line.split()
        v = map(lambda x: int(x), v)
        g[v[0]] = v[1:]
    return g

def read_data(fname):
    d = []
    f = open(fname, 'r')
    for line in f:
        d.append(line.strip())
    return d

data = read_data('./kargerAdj.txt')
g = parse_data(data)
N = (len(g) ** 2) * math.log(len(g))
N = int(math.ceil(N))
mcut = 999999

for i in range(0, N):
    cut = karger(copy.deepcopy(g))
    if cut < mcut:
        mcut = cut
    print i, '/', N, '=>', cut, 'min is', mcut

