extends Node2D
var walk_speed := 400
var direction := Vector2(1,0)

var id : int setget set_id
var actions


func get_player_actions(id : int):
	return {
		"up": "p%d_up" % id,
		"down": "p%d_down" % id,
		"left": "p%d_left" % id,
		"right": "p%d_right" % id,
		"shoot": "p%d_shoot" % id
	}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	toggle_active(false)
	$BodyShape.connect("bullet_hit", self, "_on_BodyShape_bullet_hit")
	$BodyShape.collision_layer = 2 # 0010
	$BodyShape.collision_mask = 1  # 0001
	$BodyShape/Shooter.parent = $BodyShape

func set_id(i: int):
	actions = get_player_actions(i)
	$BodyShape/Shooter.shoot_action = actions["shoot"]
	id = i

func spawn():
	$BodyShape.random_position()
	toggle_active(true)

func get_input_direction() -> Vector2:
	var d := Vector2(0, 0)
	d.x = int(Input.is_action_pressed(actions['right'])) - int(Input.is_action_pressed(actions['left']))
	d.y = int(Input.is_action_pressed(actions['down'])) - int(Input.is_action_pressed(actions['up']))
	return d.normalized()

func _physics_process(delta: float) -> void:
	var d := get_input_direction()
	if d != Vector2(0,0):
		direction = d
		$BodyShape.move(direction * walk_speed)

func toggle_active(v : bool) -> void:
	set_process(v)
	set_physics_process(v)
	#visible = v
	$BodyShape/CollisionShape2D.disabled = (not v)
	

func _on_BodyShape_bullet_hit() -> void:
	print("Player %d hit" % id)