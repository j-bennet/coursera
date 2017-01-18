import MapReduce
import sys

"""
Matrix mulltiply
"""

mr = MapReduce.MapReduce()

# =============================
# Do not modify above this line

def mapper(record):
    matrix, r, c, v = record[0], record[1], record[2], record[3]
    for k in range(5):
        if matrix == 'a':
            mr.emit_intermediate((r, k), (c, matrix, v))
        if matrix == 'b':
            mr.emit_intermediate((k, c), (r, matrix, v))

def reducer(key, list_of_values):
    list_of_values.sort()
    total = 0
    for i in range(len(list_of_values)-1):
        idxA = list_of_values[i][0]
        idxB = list_of_values[i+1][0]
        if idxA == idxB:
            total += list_of_values[i][2] * list_of_values[i+1][2]
    mr.emit((key[0], key[1], total))

# Do not modify below this line
# =============================
if __name__ == '__main__':
  inputdata = open(sys.argv[1])
  mr.execute(inputdata, mapper, reducer)
