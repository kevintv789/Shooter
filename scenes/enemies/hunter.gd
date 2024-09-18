extends CharacterBody2D

var active: bool = false
var player_near: bool = false
var speed: int = 200
var monster_damage: int = 20
var health: int = 100

func _ready() -> void:
	$NavigationAgent2D.path_desired_distance = 4.0
	$NavigationAgent2D.target_desired_distance = 4.0
	$NavigationAgent2D.target_position = Globals.player_position

func _physics_process(_delta: float) -> void:
	var next_path_pos: Vector2 = $NavigationAgent2D.get_next_path_position()
	var direction: Vector2 = (next_path_pos - global_position).normalized()
	velocity = direction * speed
	move_and_slide()
	
	var look_angle = direction.angle()
	rotation = look_angle + PI / 2

func _on_notice_area_body_entered(_body: Node2D) -> void:
	active = true
	$AnimationPlayer.play("walk")

func _on_notice_area_body_exited(_body: Node2D) -> void:
	active = false
	$AnimationPlayer.stop()

func _on_attack_area_body_entered(_body: Node2D) -> void:
	player_near = true
	$AnimationPlayer.play("attack")

func _on_attack_area_body_exited(_body: Node2D) -> void:
	player_near = false
	$AnimationPlayer.play("walk")

func _on_navigation_timer_timeout() -> void:
	if active:
		$NavigationAgent2D.target_position = Globals.player_position

func attack() -> void:
	if player_near:
		Globals.health -= monster_damage

func hit(damage: int) -> void:
	health -= damage
	if health <= 0:
		queue_free()
