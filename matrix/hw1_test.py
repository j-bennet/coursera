from GF2 import one

#a = [one, one, 0, 0, 0, 0, 0]
#b = [0, one, one, 0, 0, 0, 0]
#c = [0, 0, one, one, 0, 0, 0]
#d = [0, 0, 0, one, one, 0, 0]
#e = [0, 0, 0, 0, one, one, 0]
#f = [0, 0, 0, 0, 0, one, one]

a = [one, one, one, 0, 0, 0, 0]
b = [0, one, one, one, 0, 0, 0]
c = [0, 0, one, one, one, 0, 0]
d = [0, 0, 0, one, one, one, 0]
e = [0, 0, 0, 0, one, one, one]
f = [0, 0, 0, 0, 0, one, one]

letters = {
    tuple(a): 'a',
    tuple(b): 'b',
    tuple(c): 'c',
    tuple(d): 'd',
    tuple(e): 'e',
    tuple(f): 'f'
}

def add_two(v, u):
    return [v[i] + u[i] for i in range(len(v))]

def add(*args):
    result = args[0]
    for i in range(1, len(args)):
        result = add_two(result, args[i])
    return result

def list_dot(u, v):
    return sum([x * y for x, y in zip(u, v)])

def permute(arr):
    result = []
    if len(arr) == 1:
        result = [arr]
    else:
        for i, e in enumerate(arr):
            for p in permute(arr[:i] + arr[i+1:]):
                if p not in result:
                    result.extend([p])
                if [[e] + p] not in result:
                    result.extend([[e] + p])
    return result

def tos(vs):
    return '[' + ' + '.join(letters[tuple(v)] for v in vs) + ']'

#for p in permute([a, b, c, d, e, f]):
#    sumv = add(*p)
#    if sumv == [0, one, 0, 0, 0, one, 0]:
#        print(tos(p), ' : ', sumv)

print('vector addition 3-1:', add([0, one, one], [one, one, one]))
print('vector addition 3-1:', add([0, one, one], [one, one, one], [one, one, one]))