$n = 0 # number of cities
$c = [] # cities
$e = nil

MAX_INT = (2**(0.size * 8 - 2) - 1)

def read_cities(filename)
	f = File.new(filename, "r")
	$n = f.gets.strip!.to_i
	$e = Array.new($n) { Array.new($n) {0} }

	while (line = f.gets)
		line.strip!
		x, y = line.split(' ', 2).map(&:to_f)
		$c.push([x, y])
	end
	f.close
end

def calculate_edges
	for i in 0...$e.length
		for j in 0...$e[0].length
			if i > j
				euclid = Math.sqrt(($c[i][0] - $c[j][0])**2 + ($c[i][1] - $c[j][1])**2)
				$e[i][j] = euclid
				$e[j][i] = euclid
			end
		end
	end
end

def powersets(n)
	r = Array.new(n + 1) { [] }
	for i in 0...2 ** (n - 1)
		x = (i << 1) | 1 # bit 0 is always set
		bits = x.to_s(2).count('1')
		# puts "#{bits}: #{x.to_s(2)}"
		r[bits].push(x)
	end
	return r
end

def to_set(i)
	t = []
	for b in 0...i.to_s(2).length
		t.push(b) if ((i >> b) & 1) == 1
	end
	return t
end

def unset_bit(i, b)
	return ((i & ~(1 << b)) | (0 << b))
end

def tsp(ps)
	a = Array.new(2 ** $n) { Array.new($n) { MAX_INT } }
	a[1][0] = 0
	puts 'Initialized A.'

	for m in 2..$n # problem size
		puts "Problem size: #{m}..."
		for s in ps[m]
			set = to_set(s)
			for j in set
				if j != 0
					s_no_j = unset_bit(s, j)
					min_a = MAX_INT
					for k in set
						if k != j
							new_a = a[s_no_j][k] + $e[k][j]
							if min_a > new_a
								min_a = new_a
							end
						end
					end
					a[s][j] = min_a
				end
			end
		end
	end
	puts "Calculated A."

	puts "Looking for result..."
	min_path = MAX_INT
	for j in 1...$n
		new_path = a[a.length-1][j] + $e[j][0]
		if min_path > new_path
			min_path = new_path
		end
	end
	puts "Result is #{min_path}."
	return min_path
end

puts "Reading cities..."
#read_cities('t01.txt')
#read_cities('t02.txt')
#read_cities('t03.txt')
#read_cities('t04.txt')
read_cities('tsp.txt')
puts "Read #{$n} cities."

puts "Calculating edges..."
calculate_edges
puts "Calculated #{$n}x#{$n} edges."

puts "Calculating powersets..."
ps = powersets($n)
puts "Calculated powersets."

tsp(ps)

puts "#{$s}"