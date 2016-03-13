## Task 1
minutes_in_week = 7 * 24 * 60

## Task 2
remainder_without_mod = 2304811 - (2304811 // 47 * 47)

## Task 3
divisible_by_3 = ((673 + 909) % 3) == 0

## Task 4
x = -9
y = 1/2
statement_val = 2**(y+1/2) if x+10<0 else 2**(y-1/2)

## Task 5
first_five_squares = { _*_ for _ in {1,2,3,4,5} }

## Task 6
first_five_pows_two = { 2**_ for _ in {0,1,2,3,4} }

## Task 7: enter in the two new sets
X1 = { 1, 2, 3 }
Y1 = { 5, 7, 11 }

## Task 8: enter in the two new sets
X2 = { 3, 6, 12 }
Y2 = { 0, 1, 2 }

## Task 9
base = 10
digits = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9}
three_digits_set = { a*base**2 + b*base + c for a in digits for b in digits for c in digits }

## Task 10
S = {1, 2, 3, 4}
T = {3, 4, 5, 6}
S_intersect_T = { s for s in S for t in T if s in T and t in S }

## Task 11
L_average = sum([20, 10, 15, 75]) / 4

## Task 12
LofL = [[.25, .75, .1], [-1, 0], [4, 4, 4, 4]]
LofL_sum = sum(sum(_) for _ in LofL)

## Task 13
cartesian_product = [ [l, n] for l in {'A','B','C'} for n in {1,2,3} ]

## Task 14
S = {-4, -2, 1, 2, 5, 0}
zero_sum_list = [ (i, j, k) for i in S for j in S for k in S  if (i + j + k) == 0 ]

## Task 15
exclude_zero_list = [ (i, j, k) for i in S for j in S for k in S  if (i + j + k) == 0 and not (i == j == k) ]

## Task 16
first_of_tuples_list = [ (i, j, k) for i in S for j in S for k in S  if (i + j + k) == 0 and not (i == j == k) ][0]

## Task 17
L1 = [1, 1, 2] # <-- want len(L1) != len(list(set(L1)))
L2 = [3, 2, 1] # <-- same len(L2) == len(list(set(L2))) but L2 != list(set(L2))

## Task 18
odd_num_list_range = { _ for _ in range(1, 100, 2) }

## Task 19
L = ['A','B','C','D','E']
range_and_zip = list(zip(range(5), L))

## Task 20
list_sum_zip = [sum(x) for x in zip([10, 25, 40], [1, 15, 20])]

## Task 21
dlist = [{'James':'Sean', 'director':'Terence'}, {'James':'Roger', 'director':'Lewis'}, {'James':'Pierce', 'director':'Roger'}]
k = 'James'
value_list = [ d[k] for d in dlist ]

## Task 22
dlist = [{'Bilbo':'Ian','Frodo':'Elijah'},{'Bilbo':'Martin','Thorin':'Richard'}]
k = 'Bilbo'
value_list_modified_1 = [ d[k] if k in d else 'NOT PRESENT' for d in dlist ] # <-- Use the same expression here
k = 'Frodo'
value_list_modified_2 = [ d[k] if k in d else 'NOT PRESENT' for d in dlist ] # <-- as you do here

## Task 23
square_dict = { i:i*i for i in range(100) }

## Task 24
D = {'red','white','blue'}
identity_dict = { d:d for d in D }

## Task 25
base = 10
digits = set(range(10))
representation_dict = { (a*base*base + b*base + c):[a, b, c] for a in digits for b in digits for c in digits }

## Task 26
d = {0:1000.0, 1:1200.50, 2:990}
names = ['Larry', 'Curly', 'Moe']
listdict2dict = { names[i]:d[i] for i in range(len(names)) if i in d }

## Task 27
def nextInts(L): return [ i+1 for i in L ]

## Task 28
def cubes(L): return [ i*i*i for i in L ] 

## Task 29
def dict2list(dct, keylist): return [ dct[k] for k in keylist ]

## Task 30 
def list2dict(L, keylist): return { a:b for (a, b) in zip(keylist, L) }

