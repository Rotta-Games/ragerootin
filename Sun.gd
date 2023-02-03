extends PointLight2D

var angle = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	angle = angle + (0.5 * delta)
	
	var point = get_viewport_rect().get_center()
	
	position = point + Vector2(cos(angle), sin(angle)) * 420
	position = point + (position - point).rotated(angle)
	look_at(point)



