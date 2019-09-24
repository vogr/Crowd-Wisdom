extends KinematicBody2D

var view_size: Vector2

var rng := RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rng.randomize()
	view_size = get_viewport_rect().size

func move(velocity: Vector2) -> void:
	move_and_slide(velocity)
	set_global_rotation(velocity.angle())
	#look_at(position + velocity)
	position.x = fposmod(position.x, view_size.x)
	position.y = fposmod(position.y, view_size.y)


signal bullet_hit
func bullet_hit() -> void:
	emit_signal("bullet_hit")

func random_position() -> void:
	position.x = rng.randf_range(0, view_size.x)
	position.y = rng.randf_range(0, view_size.y)