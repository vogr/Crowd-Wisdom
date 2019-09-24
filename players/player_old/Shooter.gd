extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _physics_process(delta : float) -> void:
	if Input.is_action_pressed("shoot") and $ShootCooldown.is_stopped():
		$ShootCooldown.start()
		var b = bullet.instance()
		b.direction = owner.direction
		self.add_child(b)

var bullet : PackedScene = preload("bullet/Bullet.tscn")
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("shoot") and $ShootCooldown.is_stopped():
		$ShootCooldown.start()
		var b = bullet.instance()
		b.direction = owner.direction
		self.add_child(b)
