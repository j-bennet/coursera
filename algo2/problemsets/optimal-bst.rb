k = [1, 2, 3, 4, 5, 6, 7]
w = [0.2, 0.05, 0.17, 0.1, 0.2, 0.03, 0.25]

a = []
for r in 0...k.length
	a[r] = Array.new(k.length, 0)
end

def dbg(a)
	puts "---"
	for row in a
		puts "#{row}"
	end
end

for s in 0...k.length
	for i in 0...k.length
		j = i + s
		next if j >= k.length

		p = 0
		for t in i..j
			p += w[t]
		end
		
		x = nil
		for r in i..j
			a1 = 0
			a2 = 0
			
			a1 = a[i][r-1] if r > 0
			a2 = a[r+1][j] if r < (k.length - 1)
			
			new_x = p + a1 + a2
			x = new_x if ((x == nil) || (new_x < x))
		end

		a[i][j] = x

		# dbg(a)

	end
end

print a[0][k.length-1]