extends "res://player.gd"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	if Input.is_action_pressed("player1_move_left"):
		root.angle += -root.turn_speed
	if Input.is_action_pressed("player1_move_right"):
		root.angle += root.turn_speed


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
