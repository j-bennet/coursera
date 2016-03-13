FILENAME = 'knapsack1.txt'

$v = []
$w = []

$m = 0 # max weight
$n = 0 # number of items

$a = []

def read_items
	f = File.new(FILENAME, "r")
	$m, $n = f.gets.strip!.split(' ', 2).map(&:to_i)

	while (line = f.gets)
		line.strip!
		v, w = line.split(' ', 2).map(&:to_i)
		
		$v.push(v)
		$w.push(w)
	end
	f.close
end

def knapsack
	$a = []
	for i in 0...$w.length
		$a[i] = Array.new($m, 0)
	end

	for i in 1...$w.length
		for x in 0...$m
			
			a_exc = 0
			a_inc = 0

			a_exc = $a[i-1][x]
			a_inc = $a[i-1][x-$w[i]] + $v[i] unless $w[i] > x

			$a[i][x] = [a_exc, a_inc].max
		end
	end

end

read_items
knapsack

puts "#{$a[$n-1][$m-1]}"