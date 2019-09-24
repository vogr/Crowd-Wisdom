extends "../Body.gd"

var screen_size: Vector2
const Body = preload("../Body.tscn")
var body := Body.instance()
var walk_speed := 400
var direction := Vector2(0,1)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size

func get_direction() -> Vector2:
	var d := Vector2(0, 0)
	d.x = int(Input.is_action_pressed('ui_right')) - int(Input.is_action_pressed('ui_left'))
	d.y = int(Input.is_action_pressed('ui_down')) - int(Input.is_action_pressed('ui_up'))
	return d.normalized()
	
func _physics_process(delta: float) -> void:
	var d := get_direction()
	print(d)
	if d != Vector2(0,0):
		direction = d
		move_and_slide(direction * walk_speed)
	position.x = fposmod(position.x, screen_size.x)
	position.y = fposmod(position.y, screen_size.y)

