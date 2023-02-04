extends Node2D


@onready var area = $Area2D

var amount = 100
var drain_speed = 10

var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	var angles = [PI, 2* PI, PI/2, (3*PI)/2]
	var rand_index = rng.randi() % angles.size()
	self.rotation = angles[rand_index]
	_on_animated_sprite_2d_animation_finished()


func _process(delta):
	var areas = area.get_overlapping_areas()
	var count = areas.size()

	if count or amount <= 20:
		# small drainage when amount is low
		amount -= delta + count * delta * drain_speed
		self.scale = Vector2(amount/100, amount/100)
		if amount <= 0:
			self.queue_free()

func _on_animated_sprite_2d_animation_finished():
	var seconds = rng.randf_range(2.0, 5.0)
	$Timer.start(seconds)

func _on_timer_timeout():
	$AnimatedSprite2D.play("default")
