extends Node2D

class_name LevelParent

# Preload scenes
var laser_scene: PackedScene = preload("res://scenes/projectiles/laser.tscn")
var grenade_scene: PackedScene = preload("res://scenes/projectiles/grenade.tscn")
var item_scene: PackedScene = preload("res://scenes/items/item.tscn")

func _ready() -> void:
	# Get all nodes in the group "Container"
	var containers = get_tree().get_nodes_in_group("Container")
	var scouts = get_tree().get_nodes_in_group("Scouts")
	for container in containers:
		container.connect("lid_opened", _on_container_opened)

	for scout in scouts:
		scout.connect("scout_attack", _on_scout_attack)

func _on_container_opened(pos: Vector2, direction: Vector2) -> void:
	var item = item_scene.instantiate()
	item.position = pos
	item.direction = direction
	$Items.call_deferred('add_child', item)
	
func _on_scout_attack(pos: Vector2, direction: Vector2) -> void:
	create_laser(pos, direction)

func _on_player_player_laser_shot(pos: Vector2, direction: Vector2) -> void:
	create_laser(pos, direction)

func create_laser(pos: Vector2, direction: Vector2) -> void:
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
	
