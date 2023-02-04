extends ParallaxBackground

var creditsTextState = 0
const creditsTextScrollSpeed = 25

# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.creditsTextState = self.creditsTextState - self.creditsTextScrollSpeed * delta
	set_scroll_offset(Vector2(0,self.creditsTextState))

func _input(event):
	if event.is_pressed() or event.is_action("ui_accept"):
		get_tree().change_scene_to_file("res://main.tscn")
