extends "res://player.gd"

@onready var slider = $Player1Slider

func _physics_process(delta):
	if Input.is_action_pressed("player1_move_left"):
		root.angle += -root.turn_speed * delta
	if Input.is_action_pressed("player1_move_right"):
		root.angle += root.turn_speed * delta
