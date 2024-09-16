extends LevelParent


@onready var inside_level_scene: PackedScene = preload("res://scenes/levels/inside.tscn")

func _on_gate_player_entered_gate(_body: Node2D) -> void:
	var tween = create_tween()
	tween.tween_property($Player, "SPEED", 0, 0.5)
	call_deferred("_change_scene")

func _change_scene() -> void:
	if inside_level_scene:
		TransitionLayer.change_scene(inside_level_scene)
	else:
		print("Inside level scene is not loaded")
