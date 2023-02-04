extends Node2D

@onready var player1 = $Player1
@onready var player2 = $Player2

@onready var planet = $Planet

func _ready():
	planet.connect("planet_dry", self.winrar, CONNECT_ONE_SHOT)

func winrar():
	print("player1 score: ", player1.score)
	print("player2 score: ", player2.score)


