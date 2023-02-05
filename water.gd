extends Node2D


@onready var area = $Area2D
@onready var sprite = $Area2D/AnimatedSprite2D
@onready var body = $Area2D/CollisionShape2D

const MAX_AMOUNT = 100
@export var amount = MAX_AMOUNT
var drain_speed = 2

var start_amount: float

var rng = RandomNumberGenerator.new()

signal player_drain

# Called when the node enters the scene tree for the first time.
func _ready():
	start_amount = amount
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
		var p1_drain = int(p1_found) * delta * drain_speed
		var p2_drain = int(p2_found) * delta * drain_speed

		emit_signal("player_drain", p1_drain, p2_drain)

		# small drainage when amount is low
		amount -= delta + p1_drain + p2_drain
		var sprite_scale = amount/start_amount
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
