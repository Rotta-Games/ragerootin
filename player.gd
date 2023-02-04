extends Sprite2D

@onready var root = $Root

func set_angle(angle):
	root.angle = angle

func set_layers(own: int, enemy: int):
	root.set_layers(own, enemy)


func _input(event):
	if Input.is_action_pressed("player1_move_left"):
		root.angle += -root.turn_speed
	if Input.is_action_pressed("player1_move_right"):
		root.angle += root.turn_speed

	# if event is InputEventMouseButton:
	# 	if event.button_index == 1 and event.is_pressed():
	# 		add_point(line1, event.position)
	# 	if event.button_index == 2 and event.is_pressed():
	# 		add_point(line2, event.position)


