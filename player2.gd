extends "res://player.gd"

@onready var slider = $"../Player2Slider"
@onready var sliderButton =  $"../Player2Slider/SliderButton"

func _physics_process(delta):
	if Input.is_action_pressed("player2_move_left"):
		if state == SETUP:
			slider.move_left()
		elif state == MOVING:
			root.angle += -root.turn_speed * delta
	if Input.is_action_pressed("player2_move_right"):
		if state == SETUP:
			slider.move_right()
		elif state == MOVING:
			root.angle += root.turn_speed * delta

func _input(event):
	if state == SETUP && Input.is_action_pressed("player2_shoot"):
		self.set_global_position(sliderButton.get_global_position())
		shoot()
