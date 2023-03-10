extends Node2D

@export var root_texture: CompressedTexture2D

@onready var die_timer = $DieTimer

var root_scene = preload("res://root.tscn")

var root = null

@export var own_layer = 0
@export var enemy_layer = 0

var start_pos = Vector2(0, 0)
var alive = true

enum {END, SETUP, MOVING}

var state = SETUP

var WATER_LAYER_MASK = 3
const DRYING_SPEED = 10

signal player_died

func _ready():
	pass
	
func shoot():
	if root:
		root.stop_growing()
		return
	state = MOVING
	root = new_root()

func set_angle(angle):
	root.angle = angle 

func do_setup():
	state = SETUP
	root = null

func set_start_position(pos):
	start_pos = to_local(pos)


func new_root():
	root = root_scene.instantiate()
	root.texture = root_texture
	root.head_pos = start_pos
	root.connect("done_growing", self.do_setup, CONNECT_ONE_SHOT)
	call_deferred("add_child", root)
	root.call_deferred("set_layers", own_layer, enemy_layer)
	root.call_deferred("init")
	root.can_have_sub_roots = true
	# root.set_layers(own_layer, enemy_layer)
	return root


func die_complete():
	emit_signal("player_died")
