extends Node2D

@onready var player1 = $Player1
@onready var player2 = $Player2
@onready var music_player = $Music
@onready var planet = $Planet

func _ready():
	planet.connect("planet_dry", self.winrar, CONNECT_ONE_SHOT)
	player1.connect("player_died", self.winrar, CONNECT_ONE_SHOT)
	player2.connect("player_died", self.winrar, CONNECT_ONE_SHOT)
	music_player.play_first()

func _exit_tree():
	music_player.stop_all()

func winrar():
	if(GameState.player1_water > GameState.player2_water):
		GameState.winner_texture = $Planet/Tree1.texture
		GameState.winner_name = "Player 1"
	else:
		GameState.winner_texture = $Planet/Tree2.texture
		GameState.winner_name = "Player 2"
	
	get_tree().change_scene_to_file("res://game_over.tscn")


