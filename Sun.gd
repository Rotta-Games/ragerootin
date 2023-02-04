extends PointLight2D

@export var distance = 500
@export var angle = 0
@export var speed = 0.3

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	angle = angle + (speed * delta)
	
	var point = get_viewport_rect().get_center()
	
	position = point + Vector2(cos(angle), sin(angle)) * distance
	position = point + (position - point).rotated(angle)
	look_at(point)



