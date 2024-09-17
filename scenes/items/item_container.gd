extends StaticBody2D
class_name ItemContainer

# We use Vector2.DOWN because these objects are DOWN facing by default
@onready var current_direction: Vector2 = Vector2.DOWN.rotated(rotation)

var opened: bool = false

signal lid_opened(pos, direction)
