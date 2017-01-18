import MapReduce
import sys

"""
Asymmetric Friend Count
"""

mr = MapReduce.MapReduce()

# =============================
# Do not modify above this line

def mapper(record):
    a, b = record[0], record[1]
    mr.emit_intermediate(a, b)
    mr.emit_intermediate(b, a)

def reducer(key, list_of_values):

    rels = {}
    for v in list_of_values:
        if v in rels:
            del rels[v]
        else:
            rels[v] = 1

    for v in rels:
        mr.emit((key, v))

# Do not modify below this line
# =============================
if __name__ == '__main__':
  inputdata = open(sys.argv[1])
  mr.execute(inputdata, mapper, reducer)
