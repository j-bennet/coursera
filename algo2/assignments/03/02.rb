FILENAME = 'knapsack2.txt'

$v = []
$w = []

$m = 0 # max weight
$n = 0 # number of items

$x = []
$h = {}

def read_items
	f = File.new(FILENAME, "r")
	$m, $n = f.gets.strip!.split(' ', 2).map(&:to_i)
	
	$w = Array.new($n, 0)
	$v = Array.new($n, 0)
	
	i = 0
	while (line = f.gets)
		line.strip!
		v, w = line.split(' ', 2).map(&:to_i)
		
		$v[i] = v
		$w[i] = w

		i += 1
	end
	f.close
end

def knapsack_i(i, mw)
	return $h[[i, mw]] if $h.has_key?([i, mw])

	if ((i < 0) || (mw <= 0))
		$h[[i, mw]] = 0
		return 0
	end
	
	if $w[i] > mw
		$h[[i, mw]] = knapsack_i(i - 1, mw)
		return $h[[i, mw]]
	end
	
	a_exc = knapsack_i(i - 1, mw)
	a_inc = knapsack_i(i - 1, mw - $w[i]) + $v[i]
	$h[[i, mw]] = [a_inc, a_exc].max
	return $h[[i, mw]]
end

def knapsack
	$x = knapsack_i($n-1, $m)
end

read_items
knapsack

puts "#{$x}"