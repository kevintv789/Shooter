extends LevelParent

# Preload the scene first so we don't have to load it on scene change
@onready var outside_level_scene: PackedScene = load("res://scenes/levels/outside.tscn")

func _on_exit_gate_area_body_entered(_body: Node2D) -> void:
	var tween = create_tween()
	tween.tween_property($Player, "SPEED", 0, 0.5)
	call_deferred("_change_scene")

func _change_scene() -> void:
	if outside_level_scene:
		TransitionLayer.change_scene(outside_level_scene)
	else:
		print("Outside level scene is not loaded")
