extends Area2D

var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	var angles = [PI, 2* PI, PI/2, (3*PI)/2]
	var rand_index = rng.randi() % angles.size()
	self.rotation = angles[rand_index]
	_on_animated_sprite_2d_animation_finished()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_animated_sprite_2d_animation_finished():
	var seconds = rng.randf_range(2.0, 5.0)
	$Timer.start(seconds)

func _on_timer_timeout():
	$AnimatedSprite2D.play("default")
