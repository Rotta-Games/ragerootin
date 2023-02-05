extends "res://player.gd"

@onready var slider = $"../Player1Slider"
@onready var sliderButton =  $"../Player1Slider/SliderButton"
@onready var leafs = $"../Planet/Tree1/Leafs"
	

func _physics_process(delta):
	if Input.is_action_pressed("player1_move_left") || Input.is_action_pressed("player1_move_up"):
		if state == SETUP:
			slider.move_left()
		elif state == MOVING:
			root.angle += -root.turn_speed * delta
	if Input.is_action_pressed("player1_move_right") || Input.is_action_pressed("player1_move_down"):
		if state == SETUP:
			slider.move_right()
		elif state == MOVING:
			root.angle += root.turn_speed * delta

func _process(delta):
	if score > 0:
		score = score - 0.1
	
	var red = ((score + 40) / 100)
	var green = ((score + 20) / 100) 
	var blue = (score / 100)

	leafs.modulate = Color(red, green, blue, 1)
	
func _ready():
	score = 100

	
func _input(event):
	if Input.is_action_just_pressed("player1_shoot"):
		self.set_start_position(sliderButton.get_global_position())
		shoot()
