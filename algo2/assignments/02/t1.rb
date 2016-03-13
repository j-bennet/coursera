n = "01".to_i(2)

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

ones = one_bit_flips(n)
twos = two_bit_flips(n)

puts ones
puts twos