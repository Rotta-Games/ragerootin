extends Node2D

@export var move_speed = 0.03
@onready var path = $Path2D
@onready var button = $"SliderButton"
var patrol_points
var patrol_index = 0
var t = 0.5


func _ready():
	if path:
		patrol_points = path.curve.get_baked_points()

func move_right(): 
	if (t < 1):
		t += move_speed

func move_left():
	if (t >= 0.05):
		t -= move_speed

func _physics_process(delta):
	button.position = path.curve.sample_baked(t * path.curve.get_baked_length(), true)

	
	
