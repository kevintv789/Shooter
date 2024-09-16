extends CharacterBody2D

const SPEED: int = 100
var is_enemy: bool = true

func _process(_delta: float):
	# direction
	var direction = Vector2.RIGHT

	# velocity
	velocity = direction * SPEED

	# move_and_slide
	move_and_slide()

func hit():
	print("DAMAGED")


func _on_timer_timeout() -> void:
	pass # Replace with function body.
