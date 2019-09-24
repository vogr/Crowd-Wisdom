extends Node2D

var shoot_action

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _physics_process(delta : float) -> void:
	if Input.is_action_pressed(shoot_action) and $ShootCooldown.is_stopped():
		shoot()

var bullet : PackedScene = preload("bullet/Bullet.tscn")
func _input(event: InputEvent) -> void:
	if event.is_action_pressed(shoot_action) and $ShootCooldown.is_stopped():
		shoot()

var parent = get_parent()

func shoot():
	$ShootCooldown.start()
	var b = bullet.instance()
	get_owner().add_child(b)
	# Previously : I used 'set_as_toplevel'. This is a bad idea as
	# the bullet then ignores ALL transformations on parent nodes (in particular
	# scale transformations). The solution is to make the bullet a child of
	# a common parent that does not move, but can be scaled (here: Player).
	b.add_collision_exception_with(parent)
	b.set_direction(owner.direction)
	b.set_position(parent.position)
