extends Node2D


@onready var area = $Area2D

var amount = 100
var drain_speed = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	var areas = area.get_overlapping_areas()
	var count = areas.size()

	if count or amount <= 20:
		# small drainage when amount is low
		amount -= delta + count * delta * drain_speed
		self.scale = Vector2(amount/100, amount/100)
		if amount <= 0:
			self.queue_free()

