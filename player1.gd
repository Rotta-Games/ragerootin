extends "res://player.gd"

@onready var slider = $"../Player1Slider"
@onready var sliderButton =  $"../Player1Slider/SliderButton"
	
func _physics_process(delta):
	if Input.is_action_pressed("player1_move_left"):
		if state == SETUP:
			slider.move_left()
		elif state == MOVING:
			root.angle += -root.turn_speed * delta
	if Input.is_action_pressed("player1_move_right"):
		if state == SETUP:
			slider.move_right()
		elif state == MOVING:
			root.angle += root.turn_speed * delta

func _input(event):
	if Input.is_action_pressed("player1_shoot"):
		self.set_start_position(sliderButton.get_global_position())
		shoot()
