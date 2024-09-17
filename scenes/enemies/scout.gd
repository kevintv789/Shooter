extends CharacterBody2D

var player_nearby: bool = false
var can_attack: bool = true
var attack_cooldown: float = 1.0
var gun_attacked_index: int = 0

signal scout_attack(pos: Vector2, direction: Vector2)

func _process(_delta: float) -> void:
	var player_position = Globals.player_position
	look_at(player_position)
	if player_nearby:
		# Attack when player is within the attack area
		if can_attack:
			var shot_from_gun = $LaserSpawnPositions.get_child(gun_attacked_index)
			var pos: Vector2 = shot_from_gun.global_position
			var direction: Vector2 = (player_position - position).normalized()
			scout_attack.emit(pos, direction)
			can_attack = false
			$LaserCooldown.start(attack_cooldown)


func _on_attack_area_body_entered(_body: Node2D) -> void:
	player_nearby = true


func _on_attack_area_body_exited(_body: Node2D) -> void:
	player_nearby = false


func _on_laser_cooldown_timeout() -> void:
	# This allows the scout to shoot from altnerate guns
	gun_attacked_index += 1
	if gun_attacked_index >= $LaserSpawnPositions.get_child_count():
		gun_attacked_index = 0
	can_attack = true
