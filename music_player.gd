extends Node

@onready var audio_player_loop = $AudioStreamPlayerLoop
@onready var audio_player_intro = $AudioStreamPlayerIntro
@export var loop_stream : AudioStream 


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_audio_stream_player_intro_finished():
	audio_player_loop.play()

func play_first():
	audio_player_intro.play()

func stop_all():
	audio_player_intro.stop()
	audio_player_loop.stop()

