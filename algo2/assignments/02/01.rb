K = 4
#FILENAME = 't1-0.txt'
#FILENAME = 't1-1.txt'
#FILENAME = 't1-2.txt'
FILENAME = 'clustering1.txt'

$edges = []
$nodes = {}
$leader = {}

def read_graph
	f = File.new(FILENAME, "r")
	n = Integer(f.gets.strip!)

	i = 0

	while (line = f.gets)
		line.strip!
		v, w, c = line.split(' ', 3).map(&:to_i)
		$edges[i] = [v, w, c]
		
		$nodes[v] = v
		$nodes[w] = w

		$leader[v] = 1
		$leader[w] = 1
		
		i += 1
	end
	f.close
end

def merge_nodes(x, y)
	if $nodes[x] == $nodes[y]
		# puts "--- #{x} and #{y} already merged"
		return
	end

	src, dst = $nodes[y], $nodes[x]
	if ($leader[src] < $leader[dst])
		src, dst = $nodes[x], $nodes[y]
	end
	
	merged = 0
	$nodes.keys.each { |k|
		if $nodes[k] == src
			$nodes[k] = dst
			$leader.delete(k)
			merged += 1
			# puts "leader of #{k}: was #{src}, now #{dst}"
		end
	}
	$leader[dst] += merged
	# puts "New leaders: #{$leader}"
end

def find_spacing
	spacing = nil
	$edges.each { |v|
		x, y, c = *v
		if $nodes[x] != $nodes[y]
			if (spacing == nil) or (c < spacing)
				# puts "Spacing: #{c} (#{x}[#{$nodes[x]}]-#{y}[#{$nodes[y]}])"
				spacing = c
			end
		end
	}
	return spacing
end

read_graph
# puts "Edges: #{$edges.length}"
edges_by_weight = $edges.sort_by { |v| v[2] }

# puts "Edges by weight: #{edges_by_weight.length}"

for i in 0...edges_by_weight.length
	v, w, c = edges_by_weight[i]
	# puts "#{i}) #{c}, #{v} (#{$nodes[v]}) - #{w} (#{$nodes[w]})"
	merge_nodes(v, w)
	break if $leader.length <= K
end

spacing = find_spacing

# puts "Leaders: #{$leader}"
puts "Spacing: #{spacing}"
