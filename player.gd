extends Sprite2D

@onready var root = $Root

func set_angle(angle):
	root.angle = angle

func set_layers(own: int, enemy: int):
	root.set_layers(own, enemy)
