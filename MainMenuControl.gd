extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$VBoxContainer/NewGameButton.grab_focus()
	logoDrop()

func _on_timer_timeout():
	get_tree().change_scene_to_file("res://game.tscn")

func onNewGameButtonPressed():
	$Timer.start()

	var tween_scale = $Planet.create_tween()
	var tween_position = $Planet.create_tween()
	
	tween_scale.tween_property($Planet, "scale", Vector2(1.0,1.0), 5)
	tween_position.tween_property($Planet, "position", Vector2(320,180), 5)
	
	var tween_menu_position = $VBoxContainer.create_tween()
	tween_menu_position.tween_property($VBoxContainer, "position", Vector2($VBoxContainer.position.x, 550), 5)

func logoDrop():
	var tween = $VBoxContainer/Logo.create_tween()

	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_BOUNCE)
	
	tween.tween_property($VBoxContainer/Logo, "position", $VBoxContainer/Logo_Position.position, 3)

func onCreditsButtonPressed():
	get_tree().change_scene_to_file("res://credits.tscn")

func onQuitGameButtonPressed():
	get_tree().quit()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
