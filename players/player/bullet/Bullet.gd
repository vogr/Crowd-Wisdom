extends KinematicBody2D

var speed := 1300
var direction : Vector2 setget set_direction
var screen_size : Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size
	
func _physics_process(delta : float) -> void:
	if is_outside_view_bounds():
		queue_free()
	var collision : KinematicCollision2D = move_and_collide(delta * speed * direction)
	if collision:
		if collision.collider.has_method("bullet_hit"):
            collision.collider.bullet_hit()
		queue_free()

func set_direction(d : Vector2) -> void:
	look_at(d)
	direction = d

func is_outside_view_bounds() -> bool:
	return position.x > screen_size.x or position.x < 0.0 \
	  or position.y > screen_size.y or position.y < 0.0