extends Node2D

@onready var player1 = $Player1
@onready var player2 = $Player2

@onready var planet = $Planet

func _ready():
	planet.connect("planet_dry", self.winrar, CONNECT_ONE_SHOT)

func winrar():
	if(GameState.player1_water > GameState.player2_water):
		GameState.winner_texture = $Planet/Tree1.texture
	else:
		GameState.winner_texture = $Planet/Tree2.texture
	
	get_tree().change_scene_to_file("res://game_over.tscn")


