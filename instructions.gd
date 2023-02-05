extends Node2D

func _input(event):
	if event.is_pressed() or event.is_action("ui_accept"):
		get_tree().change_scene_to_file("res://main.tscn")
