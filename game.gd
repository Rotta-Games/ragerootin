extends Node2D

@export var water_scene: PackedScene

@export var water_amount = 20
@export var water_rings = 4

@onready var root1 = $Player1/Root
@onready var root2 = $Player2/Root2

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	_generate_water()

	root2.angle = 90
	root1.set_layers(1, 2)
	root2.set_layers(2, 1)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _generate_water():
	var earthPos = $Earth.position
	var max_radius = $Earth/CollisionShape2D.shape.radius
	var distance_between_rings = max_radius / water_rings;
	var water_per_rings = water_amount / water_rings
	
	for radius in range(1,max_radius,distance_between_rings):
		for j in water_per_rings:
			var water_position = earthPos
			var angle = randf_range(0, radius)* PI * 2
			
			water_position.x = (cos(angle) * radius) + earthPos.x
			water_position.y = (sin(angle) * radius) + earthPos.y
			
			var water = water_scene.instantiate()
			add_child(water)
			water.set_global_position(water_position)
