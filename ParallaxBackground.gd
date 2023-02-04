extends ParallaxBackground

var offsetLoc = 0
const parallaxSpeed = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(true) # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.offsetLoc = self.offsetLoc - self.parallaxSpeed * delta
	set_scroll_offset(Vector2(self.offsetLoc,0))
