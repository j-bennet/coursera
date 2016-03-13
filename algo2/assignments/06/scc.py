import time
import operator

visited = {}
leaders = {}
finish = {}

s = None
t = 0

def scc(g):
    global finish
    x = time.time()
    g_rev = reverse_graph(g)
    print 'Reversed graph in:', time.time() - x

#    print 'Original:'
#    print_graph(g)
#    print 'Reversed:'
#    print_graph(g_rev)
    
    x = time.time()
    dfs_loop(g_rev, True)
    print 'First dfs loop:', time.time() - x
#    print 'Finish times:', finish

    x = time.time()
    dfs_loop(g, False)
    print 'Second dfs loop:', time.time() - x

#    print 'Leaders:'
#    print_graph(leaders)

    components = {}
    component_leaders = {}
    for v, l in leaders.iteritems():
        if l not in component_leaders: component_leaders[l] = {}
        component_leaders[l][v] = True

        if l in components:
            components[l] += 1
        else:
            components[l] = 1
    
    #vcomponents = sorted(components.values(), reverse=True)
    #vcomponents = vcomponents[0:5]

    #print 'Components:', vcomponents
    
    is2sat = True
    for l in component_leaders.keys():
        for v in component_leaders[l].keys():
            if -v in component_leaders[l]:
                print "%d and %d belong to the same leader: %d" % (v, -v, l)
                is2sat = False
                break
    
    print '2-SAT:', is2sat

def reverse_graph(g):
    r = {}
    for k in g:
        for v in g[k]:
            if v in r:
                r[v].append(k)
            else:
                r[v] = [k]
        
        if k not in r:
            r[k] = []

    return r

def dfs_loop(g, is_first_loop):
    global visited, finish, s, t
    
    t = 0
    s = None
    visited = {}
    
    keys = []
    if is_first_loop:
        keys = sorted(g.keys(), reverse=True)
    else:
        keys = sorted(finish.iteritems(), key=operator.itemgetter(1), reverse=True)
        keys = map(lambda x: x[0], keys)
    
#    print 'Keys:', keys

    for node in keys:
        if node not in visited:
#            print 'Dfs from:', node
            s = node
            dfs(g, node, is_first_loop)

def dfs(g, start, is_first_loop):
    global leaders, visited, finish, s, t
    
    stack = []
    stack.append(start)
    
    while len(stack) > 0:
        
        current = stack[len(stack) - 1]
        visited[current] = True
#        print 'Pop:', current, stack
        
        if not is_first_loop:
            leaders[current] = s
        
        appended = False
        if current in g:
            for v in g[current]:
                if v not in visited:
                    appended = True
                    stack.append(v)
#                    print 'Push:', current, '=>', v, stack

        if not appended:
            stack.pop(len(stack) - 1)
    
        if is_first_loop and not appended:
            t += 1
            finish[current] = t

def parse_data(data):
    g = {}
    for line in data:
        v = map(int, line.split())
        if v[0] in g:
            g[v[0]].append(v[1])
        else:
            g[v[0]] = [v[1]]
    return g

def read_graph(fname):
    g = {}
    f = open(fname, 'r')
    i = 0

    for line in f:
        if i == 0:
            cnt = int(line.strip())
            print "Variables:", cnt
        else:
            (u, v) = map(int, line.strip().split())
            if not u in g: g[u] = []
            if not v in g: g[v] = []
            if not -u in g: g[-u] = []
            if not -v in g: g[-v] = []

            g[-u].append(v)
            g[-v].append(u)
        
        i += 1

    return g

def print_graph(g):
    for k, v in g.iteritems():
        print k, '=>', v

def run_case(filename, expected):
    print "==="
    x = time.time()
    g = read_graph(filename)
    print 'Read graph in:', time.time() - x

    x = time.time()
    g = scc(g)
    print 'Expected:', expected
    print 'Run scc in:', time.time() - x

#run_case('./testcases/t01.txt', 'False')
#run_case('./testcases/t02.txt', 'True')
#run_case('./testcases/t03.txt', 'True')
#run_case('./testcases/t04.txt', 'False')
#run_case('./2sat1.txt', '?')
#run_case('./2sat2.txt', '?')
#run_case('./2sat3.txt', '?')
#run_case('./2sat4.txt', '?')
#run_case('./2sat5.txt', '?')
run_case('./2sat6.txt', '?')
