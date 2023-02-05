extends Node2D

func _process(delta):
	pass
	
func _ready():
	hide()
	process_mode = Node.PROCESS_MODE_ALWAYS
	
func _input(event):
	if event.is_action_pressed("pause"):
		GameState.paused = !GameState.paused
		get_tree().paused = GameState.paused
		if GameState.paused:
			show()
		elif !GameState.paused:
			hide()
			
	if event.is_action_pressed("enter"):
		if GameState.paused:
			get_tree().paused = false
			get_tree().change_scene_to_file("res://main.tscn")
