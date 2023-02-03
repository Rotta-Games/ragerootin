extends Sprite2D

@onready var line1 = $Line1
@onready var line2 = $Line2

var angle = 90;
var headPosition = Vector2(0, 0)
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	$RootTimer.start()
	headPosition = self.to_local(self.get_position())
	print(headPosition.angle())



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# var mouse_pos = get_viewport().get_mouse_position()
	pass

func _input(event):
	pass
#	if event is InputEventMouseButton:
#		if event.button_index == 1 and event.is_pressed():
#			add_point(line1, event.position)
#		if event.button_index == 2 and event.is_pressed():
#			add_point(line2, event.position)


func add_point(line, point):
	var last_point = line.points[-1]
	line.add_point(point)

	var body = line.get_node("Area")
	var shape = CollisionShape2D.new()
	var rect = RectangleShape2D.new()

	shape.position = (last_point + point) / 2
	shape.rotation = last_point.direction_to(point).angle()

	shape.debug_color = Color(1, 0, 0, 0.5) 

	var length = last_point.distance_to(point)
	rect.extents = Vector2(length / 2, 5)

	shape.shape = rect
	body.add_child(shape)


func _on_root_timer_timeout():
	headPosition.x = headPosition.rotated(angle).x + 1
	add_point(line1, headPosition)

