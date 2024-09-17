extends CharacterBody2D

var player_nearby: bool = false
var can_attack: bool = true
var attack_cooldown: float = 1.0
var gun_attacked_index: int = 0

var health: int = 40

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

func hit(damage: int) -> void:
	health -= damage

	$Sprite2D.material.set_shader_parameter("s_color", Color.RED)
	$Sprite2D.material.set_shader_parameter("progress", 1.0)

	# Create a timer to reset the progress back to 0
	var timer = Timer.new()
	timer.wait_time = 0.1
	timer.one_shot = true
	timer.autostart = true
	timer.connect("timeout", Callable(self, "_on_timer_timeout"))
	add_child(timer)

	if health <= 0:
		queue_free()

func _on_timer_timeout() -> void:
	$Sprite2D.material.set_shader_parameter("progress", 0.0)
