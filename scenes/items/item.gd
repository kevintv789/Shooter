extends Area2D

var rotation_speed: float = 4
var available_options = ['laser', 'laser', 'laser', 'laser', 'grenade', 'health']
var type = available_options[randi() % available_options.size()]

func _ready() -> void:
	if type == 'laser':
		$Sprite2D.modulate = Color.BLUE
	elif type == 'grenade':
		$Sprite2D.modulate = Color.RED
	elif type == 'health':
		$Sprite2D.modulate = Color.GREEN

func _process(delta: float) -> void:
	rotation += rotation_speed * delta


func _on_body_entered(body: Node2D) -> void:
	body.add_item(type)
	queue_free()
