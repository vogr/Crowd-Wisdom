extends Node2D

var number_of_ennemies := 80
var ennemy : PackedScene = load("res://players/ennemy/Ennemy.tscn")
var player : PackedScene = load("res://players/player/Player.tscn")

var display : Container
# Called when the node enters the scene tree for the first time.
func _ready():
	display = $GUI/HBoxContainer/GameCol/Viewport
	for i in range(number_of_ennemies):
		var e = ennemy.instance()
		display.add_child(e)
		e.spawn()
	for i in range(1,3):
		var p := player.instance()
		display.add_child(p)
		p.id = i
		p.spawn()
	

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("exit"):
		get_tree().quit()