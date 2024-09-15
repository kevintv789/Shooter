extends Node2D

# Preload scenes
var laser_scene: PackedScene = preload("res://scenes/projectiles/laser.tscn")
var grenade_scene: PackedScene = preload("res://scenes/projectiles/grenade.tscn")

func _on_gate_player_entered_gate(body: Node2D) -> void:
	print("HELLO WORLD", body)


func _on_player_player_laser_shot(pos: Vector2) -> void:
	var laser = laser_scene.instantiate()

	# Update laser position
	laser.position = pos

	# Add laser instance to a Node2D
	$Projectiles.add_child(laser) # add to node tree


func _on_player_player_grenade_shot(pos: Vector2) -> void:
	var grenade = grenade_scene.instantiate()
	grenade.position = pos
	$Projectiles.add_child(grenade)
