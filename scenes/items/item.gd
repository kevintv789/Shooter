extends Area2D

var rotation_speed: float = 4
var available_options = ['laser', 'laser', 'laser', 'laser', 'grenade', 'health', 'health', 'health']
var type = available_options[randi() % available_options.size()]

# The direction is instantiated within level.gd as soon as the item scene is preloaded and
# the container is opened
var direction: Vector2
var distance: int = randi_range(200, 300)

func _ready() -> void:
	if type == 'laser':
		$Sprite2D.modulate = Color.BLUE
	elif type == 'grenade':
		$Sprite2D.modulate = Color.RED
	elif type == 'health':
		$Sprite2D.modulate = Color.GREEN

	# tween
	var target_pos = position + direction * distance
	var tween = create_tween()

	tween.set_parallel(true)
	tween.tween_property(self, "position", target_pos, 0.5)
	tween.tween_property(self, "scale", Vector2(1,1), 0.3).from(Vector2.ZERO)

func _process(delta: float) -> void:
	rotation += rotation_speed * delta

func _on_body_entered(_body: Node2D) -> void:
	$AudioStreamPlayer2D.play()

	if type == 'health':
		Globals.health += 10
	elif type == 'laser':
		Globals.laser_amount += 10
	elif type == 'grenade':
		Globals.grenade_amount += 1
	
	hide()
	await $AudioStreamPlayer2D.finished
	queue_free()
	
