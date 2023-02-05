extends Node

var winner_texture : Texture2D = Texture2D.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	winner_texture = load("res://assets/gfx/tree2.png")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
