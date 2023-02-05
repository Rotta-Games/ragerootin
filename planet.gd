extends Node2D

@export var water_scene: PackedScene

var water_amount = 20
var water_rings = 3

@onready var water_container = $WaterContainer

signal planet_dry

func _ready():
	randomize()
	_generate_water()


func _process(_delta):
	if water_container.get_child_count() <= 0:
		emit_signal("planet_dry")


func _generate_water():
	var earthPos = $Earth.position
	var max_radius = $Earth/CollisionShape2D.shape.radius
	var distance_between_rings = (1 + max_radius) / water_rings;
	# var water_per_rings = int(water_amount / float(water_rings))
	
	for ring in range(1, 4):
		var radius = ring * distance_between_rings

		for part in range(4 * ring):
			var water_position = earthPos
			var part_rad = (PI/2.0)*(ring/2.0)
			var angle = randf_range(0, part_rad) + part_rad * part
			
			water_position.x = (cos(angle) * radius) + earthPos.x
			water_position.y = (sin(angle) * radius) + earthPos.y
			
			var water = water_scene.instantiate()
			water_container.add_child(water)
			water.set_global_position(water_position)
			water.connect("player_drain", self._on_player_drain_water)


func _on_player_drain_water(p1_drain, p2_drain):
	GameState.player1_water = clamp(GameState.player1_water + p1_drain, 0, 100)
	GameState.player2_water = clamp(GameState.player2_water + p2_drain, 0, 100)
