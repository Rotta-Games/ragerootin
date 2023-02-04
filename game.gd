extends Node2D

@onready var player1 = $Player1
@onready var player2 = $Player2

func _ready():
	player1.set_layers(1, 2)
	player2.set_layers(2, 1)


