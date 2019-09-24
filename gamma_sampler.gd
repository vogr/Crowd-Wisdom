
var rng : RandomNumberGenerator
var d : float
var c : float
var k : float

func _init(r : RandomNumberGenerator, shape : float, scale : float):
	rng = r
	d = shape - 1/3
	c = 1.0 / sqrt(9.0 * d)
	k = d * scale

func _ready():
	pass # Replace with function body.

func rand():
	var x : float
	var v : float
	while true:
		x = rng.randfn()
		v = 1.0 + c * x
		while v <= 0.0:
			x = rng.randfn()
			v = 1.0 + c * x
		v = v * v * v
		var x2 := x * x
		var u := rng.randf()
		if (u < 1.0 - 0.331 * x2 * x2) or (log(u) < 0.5 * x2 + d * (1.0 - v + log(v))):
			return v * k