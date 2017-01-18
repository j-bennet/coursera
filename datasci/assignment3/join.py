import MapReduce
import sys

"""
Join
"""

mr = MapReduce.MapReduce()

# =============================
# Do not modify above this line

def mapper(record):
    order_id = record[1]
    mr.emit_intermediate(order_id, record)

def reducer(key, list_of_values):
    for i in range(len(list_of_values)):
        for j in range(len(list_of_values)):
            if i != j and list_of_values[i][0] == 'order' and list_of_values[j][0] == 'line_item':
                mr.emit(list_of_values[i] + list_of_values[j])

# Do not modify below this line
# =============================
if __name__ == '__main__':
  inputdata = open(sys.argv[1])
  mr.execute(inputdata, mapper, reducer)
