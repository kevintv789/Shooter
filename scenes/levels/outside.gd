extends LevelParent

func _on_gate_player_entered_gate(_body: Node2D) -> void:
	var tween = create_tween()
	tween.tween_property($Player, "SPEED", 0, 0.5)
