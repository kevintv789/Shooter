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


func _on_house_player_entered() -> void:
	var tween: Tween = get_tree().create_tween()
	# Zoom in on the player when they enter the house
	tween.tween_property($Player/Camera2D, "zoom", Vector2(1, 1), 1).set_trans(Tween.TRANS_QUAD)


func _on_house_player_exited() -> void:
	var tween: Tween = get_tree().create_tween()
	# Zoom out on the player when they exit the house
	tween.tween_property($Player/Camera2D, "zoom", Vector2(0.5, 0.5), 1)
