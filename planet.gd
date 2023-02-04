extends Node2D

@export var water_scene: PackedScene

@export var water_amount = 20
@export var water_rings = 4

func _ready():
	randomize()
	_generate_water()


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
