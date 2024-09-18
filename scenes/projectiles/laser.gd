extends Area2D

@export var SPEED = 1000
@export var DIRECTION = Vector2.UP

var damage: int = 10

const LASER_DURATION: float = 2

func _ready() -> void:
	$Timer.start(LASER_DURATION)

func _process(delta: float) -> void:
	position += DIRECTION * SPEED * delta

func _on_body_entered(body: Node2D) -> void:
	# Check if the body has a hit function
	if body.has_method("hit"):
		body.hit(damage)
		queue_free()
	
func _on_timer_timeout() -> void:
	queue_free()
