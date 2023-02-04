extends Control

# var state = null : set = _set_state, get = _get_state
@export
var is_paused = false : set = set_is_paused
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _unhandled_input(event):
	if event.is_action_pressed("pause"):
		self.is_paused = !is_paused

func set_is_paused(value: bool):
	is_paused = value
	get_tree().paused = is_paused
	visible = is_paused
	return is_paused
	
