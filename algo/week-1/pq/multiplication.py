def multiply_r(x, y):

	if x < 10 and y < 10:
		return x * y

	dx = len(str(x))
	dy = len(str(y))
	dm = max(dx, dy)

	p = dm / 2

	a = x / pow(10, p)
	b = x - a * pow(10, p)

	c = y / pow(10, p)
	d = y - c * pow(10, p)

	z = pow(10, dm) * multiply_r(a, c) + pow(10, p) * (multiply_r(a, d) + multiply_r(b, c)) + multiply_r(b, d)

	return z

print multiply_r(5678, 1234), 5678 * 1234
print multiply_r(5678, 123), 5678 * 123
print multiply_r(5678, 12), 5678 * 12