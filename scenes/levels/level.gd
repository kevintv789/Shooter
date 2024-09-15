extends Node2D

var test_array: Array[String] = ["Test"]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Logo.rotation_degrees = 90


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Logo.rotation_degrees += 100 * delta
