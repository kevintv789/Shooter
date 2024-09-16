extends Node2D

# Preload scenes
var laser_scene: PackedScene = preload("res://scenes/projectiles/laser.tscn")
var grenade_scene: PackedScene = preload("res://scenes/projectiles/grenade.tscn")


func _on_gate_player_entered_gate(_body: Node2D) -> void:
	var tween = create_tween()
	tween.tween_property($Player, "SPEED", 0, 0.5)


func _on_player_player_laser_shot(pos: Vector2, direction: Vector2) -> void:
	var laser = laser_scene.instantiate() as Area2D

	# Update laser position
	laser.position = pos
	laser.rotation_degrees = rad_to_deg(direction.angle()) + 90
	laser.DIRECTION = direction

	# Add laser instance to a Node2D
	$Projectiles.add_child(laser)  # add to node tree


func _on_player_player_grenade_shot(pos: Vector2, direction: Vector2) -> void:
	var grenade: RigidBody2D = grenade_scene.instantiate() as RigidBody2D
	grenade.position = pos
	grenade.linear_velocity = direction * grenade.SPEED
	$Projectiles.add_child(grenade)


func _on_house_player_entered() -> void:
	var tween: Tween = get_tree().create_tween()
	# Zoom in on the player when they enter the house
	tween.tween_property($Player/Camera2D, "zoom", Vector2(1, 1), 1).set_trans(Tween.TRANS_QUAD)


func _on_house_player_exited() -> void:
	var tween: Tween = get_tree().create_tween()
	# Zoom out on the player when they exit the house
	tween.tween_property($Player/Camera2D, "zoom", Vector2(0.5, 0.5), 1)
