extends CharacterBody2D

var SPEED: int = 200
var MAX_SPEED: int = 600

var is_enemy: bool = true
var health: int = 50
var player: Node2D = null
var vulnerable: bool = true
var has_exploded: bool = false
var explosion_damage: int = 50

func _ready() -> void:
	$Explosion.hide()

func _process(delta: float):
	if player:
		if !has_exploded:
			look_at(player.global_position)
			
		var direction: Vector2 = (player.global_position - global_position).normalized()
		velocity = direction * SPEED
		var collision = move_and_collide(velocity * delta)

		if collision && !has_exploded:
			play_explosion()

			# Damage target when colliding
			var container_targets = get_tree().get_nodes_in_group("Container")
			var entity_targets = get_tree().get_nodes_in_group("Entity")
			var targets = container_targets + entity_targets
			for target in targets:
				target.hit(explosion_damage)

func hit(damage: int) -> void:
	if vulnerable:
		vulnerable = false
		$HitTimer.start()
		health -= damage

		$Sprite2D.material.set_shader_parameter("s_color", Color.RED)
		$Sprite2D.material.set_shader_parameter("progress", 1.0)

	if health <= 0:
		play_explosion()
		
func play_explosion() -> void:
	SPEED = 0
	velocity = Vector2.ZERO
	$Explosion.show()
	$AnimationPlayer.play("explosion")
	has_exploded = true

func _on_notice_area_body_entered(body: Node2D) -> void:
	player = body
	
	# Make drone speed up once it notices the player
	var tween = create_tween()
	tween.tween_property(self, "SPEED", MAX_SPEED, 2.0)

func _on_hit_timer_timeout() -> void:
	vulnerable = true
	$Sprite2D.material.set_shader_parameter("progress", 0.0)
