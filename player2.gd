extends "res://player.gd"


func _physics_process(delta):
	if Input.is_action_pressed("player2_move_left"):
		root.angle += -root.turn_speed * delta
	if Input.is_action_pressed("player2_move_right"):
		root.angle += root.turn_speed * delta
