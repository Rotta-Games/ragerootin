extends Node2D


@onready var area = $Area2D
@onready var sprite = $Area2D/AnimatedSprite2D
@onready var body = $Area2D/CollisionShape2D

const MAX_AMOUNT = 100
var amount = MAX_AMOUNT
var drain_speed = 2

var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	var angles = [PI, 2* PI, PI/2, (3*PI)/2]
	var rand_index = rng.randi() % angles.size()
	self.rotation = angles[rand_index]
	_on_animated_sprite_2d_animation_finished()


func _process(delta):
	var areas = area.get_overlapping_areas()
	var p1_found = false
	var p2_found = false
	for collision in areas:
		if collision.find_parent("Player1"):
			p1_found = true
		if collision.find_parent("Player2"):
			p2_found = true

	if p1_found or p2_found or amount <= 20:
		# small drainage when amount is low
		var count = int(p1_found) + int(p2_found)
		amount -= delta + count * delta * drain_speed
		var sprite_scale = amount/MAX_AMOUNT
		var body_scale = min(1, max(sprite_scale, sprite_scale*2))
		sprite.scale = Vector2(sprite_scale, sprite_scale)
		body.scale = Vector2(body_scale, body_scale)
		if amount <= 0:
			self.queue_free()

func _on_animated_sprite_2d_animation_finished():
	var seconds = rng.randf_range(2.0, 5.0)
	$Area2D/Timer.start(seconds)

func _on_timer_timeout():
	$Area2D/AnimatedSprite2D.play("default")
