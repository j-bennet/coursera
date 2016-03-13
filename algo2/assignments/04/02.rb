require 'priority_queue'

$m = 0 # edges
$n = 0 # vertices

$gi = {} # each node has a list of incoming edges as: [vertex, cost]
$go = {} # each node has a list of outgoing edges as: [vertex, cost]

MAX_INT = (2**(0.size * 8 - 2) - 1)

def read_graph(filename)
	puts "Reading graph..."
	f = File.new(filename, "r")
	$n, $m = f.gets.strip!.split(' ', 2).map(&:to_i)

	while (line = f.gets)
		line.strip!
		v, w, l = line.split(' ', 3).map(&:to_i)
		
		$gi[v] = [] unless $gi.has_key?(v) 
		$gi[w] = [] unless $gi.has_key?(w) 
		
		$go[v] = [] unless $go.has_key?(v) 
		$go[w] = [] unless $go.has_key?(w) 
		
		$gi[w].push([v, l])
		$go[v].push([w, l])
	end
	f.close
	
	# insert fake node # 0 with no incoming edges and all outgoing edges of weight 0
	$gi[$n+1] = []
	for k in $gi.keys
		$gi[k].push([$n+1, 0])
	end

	puts "Done reading graph."
end

def dijkstra(src)
	
	# init all to infinity, src to 0
	dist = Array.new($n) { MAX_INT }
	heap = PriorityQueue.new
	
	for v in $go.keys
		heap.push(v, MAX_INT)
		dist[v-1] = MAX_INT
	end
	
	heap.change_priority(src, 0)
	dist[src-1] = 0

	while not heap.empty?
		u, l = heap.delete_min
		if l == MAX_INT
			# the rest of vertices are all unreachable
			break
		end

		for outgoing in $go[u]
			v, l = *outgoing
			alt = dist[u-1] + l
			if alt < dist[v-1]
				dist[v-1] = alt
				heap.change_priority(v, alt)
			end
		end
	end
	return dist
end

def dd(k, d)
	if d != nil
		#puts "==="
		#d.each { |row|
		#	puts "#{row}"
		#}
		min_of_d = d.map { |row| row.min }.min
		puts "MIN for #{k}: #{min_of_d}"
		return min_of_d
	else
		puts "MIN for #{k}: nil"
	end
end

def reweigh(paths)
	for u in $go.keys
		for i in 0...$go[u].length
			v, l = *$go[u][i]
			weight = l + paths[u] - paths[v]
			$go[u][i][1] = weight
			if weight < 0
				puts "ERROR: edge < 0! #{l} + #{paths[u]} - #{paths[v]} = #{weight}"
				break
			end
		end
	end
end

def readjust(dist, src, paths)
	for i in 0...dist.length
		dst = i + 1
		dist[i] = dist[i] - (paths[src] - paths[dst])
	end
	return dist
end

def all_dijkstra(paths)
	min_of_mins = MAX_INT
	cnt = 0
	for u in $go.keys
		cnt += 1
		dx = readjust(dijkstra(u), u, paths)
		min_of_d = dx.min
		puts "#{cnt}) Min for #{u}: #{min_of_d}"
		min_of_mins = min_of_d if min_of_d < min_of_mins
	end
	puts "Min of mins: #{min_of_mins}"
end

def bellman_ford(src)
	d = Array.new($n+1) { Array.new($n+1) { MAX_INT } }
	d[0][src-1] = 0
	ix = 1

	for i in 1...$n
		
		ix = i
		any_changes = false
		
		$gi.keys.each { |v|
			t = MAX_INT
			
			$gi[v].each { |incoming|
				w, l = *incoming
				if (d[i-1][w-1] + l) < t
					t = d[i-1][w-1] + l
					any_changes = true
				end
			}

			d[i][v-1] = [d[i-1][v-1], t].min
		}
		break unless any_changes
	end
	
	# last iteration to detect negative cycles
	i = ix + 1
	negative_cycle = false

	$gi.keys.each { |v|
		$gi[v].each { |incoming|
			w, l = *incoming
			if (d[i-1][w-1] + l) < d[i-1][v-1]
				negative_cycle = true
				break
			end
		}
	}

	if not negative_cycle
		all_paths = {}
		for i in 0...$n
			all_paths[i+1] = d[ix][i]
		end
		return all_paths
	end
end

#read_graph('t1.txt')
#read_graph('t2.txt')
#read_graph('t3.txt')
#read_graph('t4.txt')

#read_graph('g1.txt')
#read_graph('g2.txt')
read_graph('g3.txt')

all_paths = bellman_ford($n+1)
if all_paths == nil
	puts "Negative cycle detected!"
else
	puts "No negative cycle, reweighing edges..."
	reweigh(all_paths)
	puts "Reweighing done. Running dijkstra..."
	all_dijkstra(all_paths)
	puts "Dijkstra done."
end
