extends Node

@onready var audio_player_loop = $AudioStreamPlayerLoop
@export var loop_stream : AudioStream 


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_audio_stream_player_intro_finished():
	audio_player_loop.play()

