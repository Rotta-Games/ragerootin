extends "res://player.gd"

@onready var slider = $"../Player2Slider"
@onready var sliderButton =  $"../Player2Slider/SliderButton"
@onready var leafs = $"../Planet/Tree2/Leafs"
@onready var leafParticles = $"../Planet/Tree2/LeafsParticles"


func _physics_process(delta):
	if not self.alive:
		return
	if Input.is_action_pressed("player2_move_left") || Input.is_action_pressed("player2_move_down"):
		if state == SETUP:
			slider.move_left()
		elif state == MOVING:
			root.angle += -root.turn_speed * delta
	if Input.is_action_pressed("player2_move_right") || Input.is_action_pressed("player2_move_up"):
		if state == SETUP:
			slider.move_right()
		elif state == MOVING:
			root.angle += root.turn_speed * delta

func _process(delta):
	if not self.alive:
		return

	GameState.player2_water -= self.DRYING_SPEED * delta
	if GameState.player2_water <= 0:
		GameState.player2_water = 0
		die()

	var score = float(GameState.player2_water)
	
	var red = (score + 40) / 100
	var green = (score + 20) / 100
	var blue = score / 100
	
	if red > 1:
		red = 1
	if green > 1:
		green = 1
	if blue > 1:
		blue = 1
		
	leafs.modulate = Color(red, green, blue, 1)

func _input(event):
	if Input.is_action_just_pressed("player2_shoot"):
		self.set_start_position(sliderButton.get_global_position())
		shoot()

func die():
	self.alive = false
	leafs.hide()
	leafParticles.restart()
	self.die_timer.start()
