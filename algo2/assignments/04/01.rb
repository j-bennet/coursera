$m = 0 # edges
$n = 0 # vertices
$g = {} # each node has a list of incoming edges as: [vertex, cost]

MAX_INT = (2**(0.size * 8 - 2) - 1)

def read_graph(filename)
	f = File.new(filename, "r")
	$n, $m = f.gets.strip!.split(' ', 2).map(&:to_i)

	while (line = f.gets)
		line.strip!
		v, w, l = line.split(' ', 3).map(&:to_i)
		
		$g[v] = [] unless $g.has_key?(v) 
		$g[w] = [] unless $g.has_key?(w) 
		
		$g[w].push([v, l])
	end
	f.close
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

def bellman_ford(src)
	d = Array.new($n) { Array.new($n) { MAX_INT } }
	d[0][src-1] = 0
	ix = 1

	for i in 1...$n
		
		ix = i
		any_changes = false
		
		$g.keys.each { |v|
			t = MAX_INT
			
			$g[v].each { |incoming|
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

	$g.keys.each { |v|
		$g[v].each { |incoming|
			w, l = *incoming
			if (d[i-1][w-1] + l) < d[i-1][v-1]
				negative_cycle = true
				break
			end
		}
	}

	return d unless negative_cycle
end

#read_graph('t1.txt')
#read_graph('t2.txt')
#read_graph('t3.txt')
#read_graph('t4.txt')

#read_graph('g1.txt')
#read_graph('g2.txt')
read_graph('g3.txt')

all_mins = []
$g.keys.each { |k|
	d = bellman_ford(k)
	if d == nil
		puts "Negative cycle detected!"
		break
	end
	
	min_of_d = dd(k, d)
	all_mins.push(min_of_d)
}
puts "All mins: #{all_mins}"
puts "Min of mins: #{all_mins.min}" if all_mins.compact.length > 0

