#fin = open("t1-1.txt", "r")
#fin = open("t1-2.txt", "r")
fin = open("jobs.txt", "r")
n = int(fin.readline().strip())

jobs = {}

for i in range(n):
    line = fin.readline().strip()
    w, l = map(int, line.split(' ', 2))
    jobs[(w-l, w, i)] = (w, l)

fin.close()

schedule = sorted(jobs.iteritems(), key=lambda(k, v): k, reverse=True)

finish_time = 0
total_finish_time = 0

for (k, (w, l)) in schedule:
	finish_time += l
	total_finish_time += w * finish_time
	#print 'k=%s, w=%d, l=%d, finish=%d, adding: w*finish=%d, total: %d' % (str(k), w, l, finish_time, w * finish_time, total_finish_time)

print 'Total:', total_finish_time