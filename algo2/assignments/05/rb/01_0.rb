def powersets(n)
	r = Array.new(n + 1) { [] }
	seen = {}
	for i in 0...2 ** (n - 1)
		x = (i << 1) | 1 # bit 0 is always set
		bits = x.to_s(2).count('1')
		# puts "#{bits}: #{x.to_s(2)}"
		r[bits].push(x)
	end
	return r
end

puts "Calculating powersets..."
ps = powersets(25)
puts "Calculated powersets."

for i in 0...ps.length
	File.open("ps/#{i}.bin", "wb") do |file|
		Marshal.dump(ps[i], file)
	end
end

# check if that worked
File.open("ps/3.bin", "rb") do |file|
	t = Marshal.load(file.read)
	puts "powersets with 3 bits set: #{t}"
end