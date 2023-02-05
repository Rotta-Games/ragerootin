extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():	
	$Tree.texture = GameState.winner_texture


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
