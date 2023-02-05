extends Node2D

var creditsTextState = 0
const creditsTextScrollSpeed = 25

# Called when the node enters the scene tree for the first time.
func _ready():
	$ParallaxBackground/Tree/Trunk.texture = GameState.winner_texture
	$ParallaxBackground/WinnerLabel.text = GameState.winner_name + " wins!"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if creditsTextState > -250:
		self.creditsTextState = self.creditsTextState - self.creditsTextScrollSpeed * delta
		$ParallaxBackground.set_scroll_offset(Vector2(0,self.creditsTextState))
