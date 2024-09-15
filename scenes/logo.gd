extends Sprite2D

# Declare globals
const SPEED: int = 200

var pos: Vector2 = Vector2.ZERO
var test_scale: float = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pos = Vector2(300, 200)
	position = pos

	test_scale = 2
	scale = Vector2(test_scale, test_scale)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pos.x += SPEED * delta
	position = pos
