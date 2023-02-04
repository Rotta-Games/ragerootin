extends Sprite2D

@export var root_texture: CompressedTexture2D

var root_scene = preload("res://root.tscn")

var root = null

@export var own_layer = 0
@export var enemy_layer = 0

enum {END, SETUP, MOVING}

var state = SETUP

var score = 0

var WATER_LAYER_MASK = 3


func _process(delta):
	var areas = root.body.get_overlapping_areas()
	for area in areas:
		if area.get_collision_layer_value(WATER_LAYER_MASK):
			self.score += 1 + delta


func _ready():
	root = new_root()

func set_angle(angle):
	root.angle = angle


func new_root():
	root = root_scene.instantiate()
	root.texture = root_texture
	root.connect("done_growing", self.new_root)
	call_deferred("add_child", root)
	root.call_deferred("set_layers", own_layer, enemy_layer)
	# root.set_layers(own_layer, enemy_layer)
	return root
