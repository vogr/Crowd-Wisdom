extends "../Body.gd"

var possible_directions = [
	Vector2(1,0),
	Vector2(-1,0),
	Vector2(0,1),
	Vector2(0,-1)
]

var rng := RandomNumberGenerator.new()
var time_since_last_turn := 0.0
var next_turn_time: float
var lambda := 0.05

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rng.randomize()
	var i := rng.randi_range(0,3)
	direction = possible_directions[i]
	possible_directions.remove(i)
	next_turn_time = gen_next_turn_time()
	._ready()

func gen_next_turn_time() -> float:
	# TODO: mieux, une loi gamma!
	return abs(rng.randfn(0.5,1))


func new_direction() -> Vector2:
	var i := rng.randi_range(0,2)
	var new_d: Vector2 = possible_directions[i]
	possible_directions.remove(i)
	possible_directions.push_front(direction)
	return new_d
	
func _physics_process(delta: float) -> void:
	if time_since_last_turn > next_turn_time:
		direction = new_direction()
		time_since_last_turn = 0.0
		next_turn_time = gen_next_turn_time()
	else:
		time_since_last_turn += delta
	move_and_slide(direction * walk_speed)
	position.x = fposmod(position.x, screen_size.x)
	._physics_process(delta)