extends Node

var winner_texture : Texture2D = Texture2D.new()
var winner_name = ""

var player1_water = 75
var player2_water = 75
var paused = false

# Called when the node enters the scene tree for the first time.
func _ready():
	winner_texture = load("res://assets/gfx/tree2_trunk.png")

func reset():
	winner_name = ""

	player1_water = 75
	player2_water = 75
	paused = false
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
