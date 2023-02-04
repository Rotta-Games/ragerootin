extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$VBoxContainer/NewGameButton.grab_focus()

func onNewGameButtonPressed():
	get_tree().change_scene_to_file("res://game.tscn")

func onQuitGameButtonPressed():
	get_tree().quit()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
