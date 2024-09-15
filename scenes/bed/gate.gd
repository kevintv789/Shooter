extends StaticBody2D

# We want to check if gate has been entered, which needs to be
# a custom signal so that the level scene can check for it
signal player_entered_gate(body: Node2D)

func _on_area_2d_body_entered(body: Node2D) -> void:
	player_entered_gate.emit(body)
