extends CharacterBody2D

var health: int = 30
var speed: int = 200

var player: Node2D = null
var player_in_range: bool = false
var vulnerable: bool = true

func _physics_process(_delta: float) -> void:
	if player:
		var direction = (player.position - position).normalized()
		# Rotate the bug to face the player
		self.velocity = direction * speed
		self.move_and_slide()
		look_at(player.global_position)

func hit(damage: int) -> void:
	if vulnerable:
		vulnerable = false
		$Timers/HitTimer.start()

		health -= damage

		$SpriteAnimation.material.set_shader_parameter("s_color", Color.RED)
		$SpriteAnimation.material.set_shader_parameter("progress", 1.0)
		$Particles/HitParticles.emitting = true

		if health <= 0:
			# Disappears after 0.5 seconds so particles can play
			await get_tree().create_timer(0.5).timeout
			queue_free()

func _on_notice_area_2d_body_entered(body: Node2D) -> void:
	player = body
	$SpriteAnimation.play("Walk")

func _on_notice_area_2d_body_exited(_body: Node2D) -> void:
	player = null
	$SpriteAnimation.stop()

func _on_attack_area_2d_body_entered(body: Node2D) -> void:
	player = body
	$SpriteAnimation.play("Attack")

func _on_attack_area_2d_body_exited(_body: Node2D) -> void:
	player = null
	$SpriteAnimation.stop()

func _on_sprite_animation_animation_finished() -> void:
	if player and player.has_method("hit"):
		player.hit(10)
		$Timers/AttackTimer.start()

func _on_attack_timer_timeout() -> void:
	$SpriteAnimation.play("Attack")

func _on_hit_timer_timeout() -> void:
	vulnerable = true
	$SpriteAnimation.material.set_shader_parameter("progress", 0.0)
