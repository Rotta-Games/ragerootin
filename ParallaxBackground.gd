extends ParallaxBackground

var slowOffsetLoc = 0
const slowParallaxSpeed = 50

# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.slowOffsetLoc = self.slowOffsetLoc - self.slowParallaxSpeed * delta
	set_scroll_offset(Vector2(self.slowOffsetLoc,0))
