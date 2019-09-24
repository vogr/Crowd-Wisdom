extends KinematicBody2D

var speed := 1300
var direction : Vector2 setget set_direction
var screen_size : Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_as_toplevel(true)
	screen_size = get_viewport_rect().size
	
func _physics_process(delta : float) -> void:
	if is_outside_view_bounds():
		queue_free()
	var collision_info : KinematicCollision2D = move_and_collide(delta * speed * direction)
	if collision_info:
		queue_free()

func set_direction(d : Vector2) -> void:
	rotation = get_angle_to(d)
	direction = d

func is_outside_view_bounds() -> bool:
	return position.x > screen_size.x or position.x < 0.0 \
	  or position.y > screen_size.y or position.y < 0.0