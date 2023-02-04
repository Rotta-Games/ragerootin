extends Node2D

@onready var player1 = $Player1
@onready var player2 = $Player2

# Called when the node enters the scene tree for the first time.
func _ready():
	player2.set_angle(90)
	player1.set_layers(1, 2)
	player2.set_layers(2, 1)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

