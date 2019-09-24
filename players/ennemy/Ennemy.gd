extends Node2D



var walk_speed := 400
var direction : Vector2

var possible_directions = [
	Vector2(1,0),
	Vector2(-1,0),
	Vector2(0,1),
	Vector2(0,-1)
]
var i_previous_direction : int
var rng := RandomNumberGenerator.new()

var alpha := 2.0
var theta := 1.0
var Gamma_sampler = load("res://gamma_sampler.gd")
var gamma = Gamma_sampler.new(rng, alpha, theta)

var time_since_last_turn := 0.0
var next_turn_time: float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rng.randomize()
	i_previous_direction = rng.randi_range(0,3)
	direction = possible_directions[i_previous_direction]
	next_turn_time = gen_next_turn_time()
	
	$BodyShape.connect("bullet_hit", self, "_on_BodyShape_bullet_hit")
	
	$BodyShape.collision_layer = 2 # 0010
	$BodyShape.collision_mask = 1  # 0001

	$BodyShape/AnimatedSprite.show()

func spawn():
	$BodyShape.random_position()
	toggle_active(true)

func gen_next_turn_time() -> float:
	return gamma.rand()

func new_direction() -> Vector2:
	var i := rng.randi_range(0,2)
	if i >= i_previous_direction:
		i_previous_direction = i + 1
	else:
		i_previous_direction = i
	return possible_directions[i]
	
func _physics_process(delta: float) -> void:
	if time_since_last_turn > next_turn_time:
		direction = new_direction()
		time_since_last_turn = 0.0
		next_turn_time = gen_next_turn_time()
	else:
		time_since_last_turn += delta
	$BodyShape.move(direction * walk_speed)

func toggle_active(v : bool) -> void:
	set_process(v)
	set_physics_process(v)
	visible = v
	$BodyShape/CollisionShape2D.disabled = (not v)
	
func _on_BodyShape_bullet_hit() -> void:
	toggle_active(false)
	queue_free()

	