extends CharacterBody2D

const SPEED: int = 100

func _process(_delta: float):
	# direction
	var direction = Vector2.RIGHT

	# velocity
	velocity = direction * SPEED

	# move_and_slide
	move_and_slide()
