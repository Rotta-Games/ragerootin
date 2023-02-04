extends Node2D

@onready var line = $Line2D
@onready var body = $Line2D/BodyArea
@onready var head = $Line2D/HeadArea
@onready var timer = $SegmentTimer
@export var speed = 200
@export var turn_speed = 10

var alive = true
var angle = 10
var head_pos = Vector2(0, 0)
var head_dir = Vector2(1, 0)

func _ready():
	head_pos = self.position
	add_point(head_pos)
	add_point(head_pos)


func set_layers(own: int, enemy: int):
	body.set_collision_layer_value(own, true)
	head.set_collision_layer_value(own, true)
	body.set_collision_mask_value(enemy, true)
	head.set_collision_mask_value(enemy, true)


func _process(delta):
	if not alive:
		return
	var rotated = head_dir.rotated(angle * delta)
	head_pos += rotated * speed * delta
	move_last_point(head_pos)


func add_point(point):
	var last_point = line.points[-1]
	line.add_point(point)

	var shape = CollisionShape2D.new()
	var rect = RectangleShape2D.new()

	shape.position = (last_point + point) / 2
	shape.rotation = last_point.direction_to(point).angle()

	var length = last_point.distance_to(point)
	rect.extents = Vector2(length / 2, 5)

	shape.shape = rect
	body.add_child(shape)


func move_last_point(point: Vector2):
	line.set_point_position(line.points.size()-1, point)
	head.position = point
	var second_last = line.points[-2]

	var shape = body.get_child(-1)
	var rect = shape.shape

	shape.position = (second_last + point) / 2
	shape.rotation = second_last.direction_to(point).angle()

	var length = second_last.distance_to(point)
	rect.extents = Vector2(length / 2, 5)


func _on_segment_timer_timeout():
	add_point(head_pos)


func _on_body_area_shape_entered(area_rid:RID, area:Area2D, area_shape_index:int, local_shape_index:int):
	if area.name == "HeadArea":
		timer.stop()

		var dead_line = line.duplicate()
		dead_line.width_curve = null
		for child in dead_line.get_children():
			child.queue_free()

		for i in range(local_shape_index + 1):
			dead_line.remove_point(0)

		call_deferred("add_child", dead_line)

		while line.points.size() > local_shape_index + 1:
			line.remove_point(line.points.size()-1)
			body.remove_child(body.get_child(-1))

		if line.has_node("HeadArea"):
			head.queue_free()

		self.alive = false
		line.width_curve = null

