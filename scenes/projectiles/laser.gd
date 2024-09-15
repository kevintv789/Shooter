extends Area2D

@export var SPEED = 1000
@export var DIRECTION = Vector2.UP

func _process(delta: float) -> void:
	position += DIRECTION * SPEED * delta
