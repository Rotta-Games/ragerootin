extends Node2D

@onready var line = $Line2D

var angle = 10
var speed = 100
var turn_speed = 10
var head_pos = Vector2(0, 0)
var head_dir = Vector2(1, 0)

func _ready():
	head_pos = self.get_position()
	add_point(line, head_pos)
	add_point(line, head_pos)


func _process(delta):
	var rotated = head_dir.rotated(angle * delta)
	head_pos += rotated * speed * delta
	move_last_point(line, head_pos)


func add_point(line, point):
	var last_point = line.points[-1]
	line.add_point(point)

	var body = line.get_node("Area2D")
	var shape = CollisionShape2D.new()
	var rect = RectangleShape2D.new()

	shape.position = (last_point + point) / 2
	shape.rotation = last_point.direction_to(point).angle()

	var length = last_point.distance_to(point)
	rect.extents = Vector2(length / 2, 5)

	shape.shape = rect
	body.add_child(shape)


func move_last_point(line: Line2D, point: Vector2):
	line.set_point_position(line.points.size()-1, point)
	var second_last = line.points[-2]

	var body = line.get_node("Area2D")
	var shape = body.get_child(-1)
	var rect = shape.shape

	shape.position = (second_last + point) / 2
	shape.rotation = second_last.direction_to(point).angle()

	var length = second_last.distance_to(point)
	rect.extents = Vector2(length / 2, 5)


func _on_segment_timer_timeout():
	add_point(line, head_pos)
