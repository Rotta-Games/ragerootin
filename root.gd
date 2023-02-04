extends Node2D

@onready var line = $Line2D
@onready var body = $Line2D/BodyArea
@onready var head = $Line2D/HeadArea

@export var speed = 60
@export var turn_speed = 270
# 0 = disabled
@export var max_length = 0

@export var texture: CompressedTexture2D = null
var root_scene = preload("res://root.tscn")

signal done_growing

const sub_root_update_delay = 5.0
const sub_root_spacing = 10

var can_have_sub_roots = false
var sub_roots = []

var rem_sub_root_update_delay = sub_root_update_delay


var DARKEN = Color(0.6, 0.6, 0.6, 1)

var max_segment_length = 5
var max_segments = int(max_length / float(max_segment_length))

var growing = true
var angle = 0
var head_pos = Vector2(0, 0)
var head_dir = Vector2(1, 0)

var own_layers = 0
var enemy_layers = 0

var rng = RandomNumberGenerator.new()
var initialized = false

func _ready():
	line.texture = self.texture
	
func init():
	self.angle = rng.randi_range(-10, 10)
	if head_pos.is_zero_approx():
		head_pos = self.position
	_init_first_point()
	
func init_with_args(pos: Vector2, angle: float):
	self.angle = angle
	self.head_pos = pos
	_init_first_point()
	
func _init_first_point():
	line.add_point(head_pos)
	add_point(head_pos)
	initialized = true

func set_layers(own: int, enemy: int):
	own_layers = own
	enemy_layers = enemy
	body.set_collision_layer_value(own, true)
	head.set_collision_layer_value(own, true)
	body.set_collision_mask_value(enemy, true)
	head.set_collision_mask_value(enemy, true)


func _process(delta):
	if not initialized:
		return
	#if can_have_sub_roots:
	#	_process_sub_roots(delta)
	if not growing:
		return
	if max_length > 0 && line.get_point_count() >= max_segments:
		stop_growing()
		return
	var rotated = head_dir.rotated(angle * delta)
	head_pos += rotated * speed * delta
	move_last_point(head_pos)

func _process_sub_roots(delta):
	rem_sub_root_update_delay -= delta
	if rem_sub_root_update_delay > 0.0:
		return
	rem_sub_root_update_delay = sub_root_update_delay
	_grow_new_sub_roots()

	
func _grow_new_sub_roots():
	while line.points.size() / sub_root_spacing > sub_roots.size():
		var sub_root_count = sub_roots.size()
		var next_idx = sub_root_count + sub_root_spacing
		var sub_root_pos = line.points[next_idx]
		var angle = line.points[next_idx - 1].angle_to(sub_root_pos)
		_grow_new_sub_root(sub_root_pos, angle)
	
func _grow_new_sub_root(pos : Vector2, parent_angle: float):
	var left_side_angle = parent_angle - deg_to_rad(rng.randi_range(30, 60))
	var right_side_angle = parent_angle + deg_to_rad(rng.randi_range(30, 60))
	_create_new_sub_root(pos, left_side_angle)
	_create_new_sub_root(pos, right_side_angle)

func _create_new_sub_root(pos: Vector2, angle: float):
	var sub_root = root_scene.instantiate()
	call_deferred("add_child", sub_root)
	sub_root.call_deferred("set_layers", own_layers, enemy_layers)
	sub_root.call_deferred("init_with_args", pos, angle)
	sub_root.can_have_sub_roots = false
	sub_root.max_length = rng.randi_range(20,80) / 2
	sub_roots.append(sub_root)
	
func add_point(point):
	var last_point = line.points[-1]
	line.add_point(point)

	var shape = CollisionShape2D.new()
	var rect = RectangleShape2D.new()

	shape.position = (last_point + point) / 2
	shape.rotation = last_point.direction_to(point).angle()

	var length = last_point.distance_to(point)
	rect.extents = Vector2(length / 2, line.width / 2)

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
	rect.extents = Vector2(length / 2, line.width / 2)

	if length >= max_segment_length:
		add_point(point)


func handle_dead_split(cut_index: int):
	# split the line in two
	var dead_line = line.duplicate()
	call_deferred("add_child", dead_line)

	dead_line.modulate = DARKEN
	dead_line.width_curve = null

	# remove dead split's collision stuff
	for child in dead_line.get_children():
		child.queue_free()

	# remove dead split's points from start to cut
	for i in range(cut_index + 1):
		dead_line.remove_point(0)

	# tween dead split's alpha
	var tween = create_tween()
	tween.tween_property(dead_line, "modulate", Color(1, 1, 1, 0), 2.0)
	tween.tween_callback(dead_line.queue_free)
	tween.tween_callback(tween.kill)


func handle_alive_split(cut_index: int):
	# remove growing split's points from cut to end
	while line.points.size() > cut_index + 1:
		line.remove_point(line.points.size()-1)
		body.remove_child(body.get_child(-1))

	# remove alive split's head collision
	if line.has_node("HeadArea"):
		head.queue_free()

	line.width_curve = null


func _on_body_area_shape_entered(_area_rid:RID, area:Area2D, _area_shape_index:int, local_shape_index:int):
	if area.name == "HeadArea":

		handle_dead_split(local_shape_index)
		handle_alive_split(local_shape_index)

		stop_growing()

func stop_growing():
	if self.growing:
		line.modulate = DARKEN
		self.growing = false
		emit_signal("done_growing")


func _on_visible_on_screen_notifier_2d_screen_exited():
	stop_growing()
