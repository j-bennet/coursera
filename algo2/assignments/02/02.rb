FILENAME = 'clustering2.txt'

$edges = []
$nodes = []
$leader = {}
$dnodes = {}

def read_graph
	f = File.new(FILENAME, "r")
	n, bits = f.gets.strip!.split(' ', 2).map(&:to_i)
	#puts "Nodes: #{n}, bits: #{bits}"

	i = 0

	while (line = f.gets)
		line.strip!
		code = line.gsub!(' ', '').to_i(2)
		#puts "#{line} => #{code}"
		
		$nodes[i] = [i, code]
		if $dnodes.has_key?(code)
			$dnodes[code].push(i)
		else
			$dnodes[code] = [i]
		end

		$leader[i] = 1

		i += 1
	end
	f.close
end

def hamming(a, b)
	return (a ^ b).to_s(2).count("1")
end

def one_bit_flips(x)
	r = []
	(0..23).each do |i|
		r.push(x ^ (1 << i))
	end
	return r
end

def two_bit_flips(x)
	r = []
	(0..23).each do |i|
		((i + 1)..23).each do |j|
			r.push(x ^ (1 << i) ^ (1 << j))
		end
	end
	return r
end

def closest_nodes(i)
	r = []
	code = $nodes[i][1]
	closest_codes = [code] + one_bit_flips(code) + two_bit_flips(code)
	closest_codes.each { |c|
		if $dnodes.has_key?(c)
			$dnodes[c].each { |v|
				r.push(v) unless v == i
			}
		end
	}
	return r
end

def calculate_edges
	# only consider edges <= 2
	# once we merge those, the algorithm will stop
	$nodes.each_index { |i|
		closest = closest_nodes(i)
		closest.each do |j|
			d = hamming($nodes[i][1], $nodes[j][1])
			$edges.push([i, j, d])
		end
	}
end

def merge_nodes(x, y)
	if $nodes[x][0] == $nodes[y][0]
		# puts "--- #{x} and #{y} already merged"
		return
	end

	src, dst = $nodes[y][0], $nodes[x][0]
	if ($leader[src] < $leader[dst])
		src, dst = $nodes[x][0], $nodes[y][0]
	end
	
	merged = 0
	$nodes.each_index { |i|
		if $nodes[i][0] == src
			$nodes[i][0] = dst
			$leader.delete(i)
			merged += 1
			# puts "leader of #{k}: was #{src}, now #{dst}"
		end
	}
	$leader[dst] += merged
	# puts "New leaders: #{$leader}"
end

read_graph
puts "Nodes: #{$nodes.length}"
#puts "Distinct: #{$dnodes.length}"

calculate_edges

puts "Edges: #{$edges.length}"

edges_by_weight = $edges.sort_by { |v| v[2] }

#puts "Edges by weight: #{edges_by_weight.length}"

for i in 0...edges_by_weight.length
	v, w, c = edges_by_weight[i]
	merge_nodes(v, w)
end

k = $leader.length
puts "Clusters: #{k}"
