extends PathFollow2D

var car_speed_ratio: float = 0.02
var player: Node2D = null

var damage: int = 20

@onready var turret_line1: Line2D = $Turret/RayCast2D/Line2D
@onready var turret_line2: Line2D = $Turret/RayCast2D2/Line2D2
@onready var gun_fire1: Sprite2D = $Turret/Gun
@onready var gun_fire2: Sprite2D = $Turret/Gun2

func _ready() -> void:
	turret_line1.add_point($Turret/RayCast2D.target_position)
	turret_line2.add_point($Turret/RayCast2D2.target_position)
	turret_line1.hide()
	turret_line2.hide()
	gun_fire1.modulate = 0
	gun_fire2.modulate = 0


func _process(delta: float) -> void:
	progress_ratio += car_speed_ratio * delta

	if player:
		$Turret.look_at(player.global_position)

func _on_notice_area_body_entered(body: Node2D) -> void:
	turret_line1.show()
	turret_line2.show()
	player = body
	$AnimationPlayer.play("laser_load")

func _on_notice_area_body_exited(_body: Node2D) -> void:
	$AnimationPlayer.pause()
	player = null
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(turret_line1, "width", 0, 0.5)
	tween.tween_property(turret_line2, "width", 0, 0.5)
	await tween.finished
	$AnimationPlayer.stop()

func fire() -> void:
	if player:
		player.hit(damage)

		gun_fire1.modulate = Color.WHITE
		gun_fire2.modulate = Color.WHITE

		var tween = create_tween()
		tween.set_parallel(true)
		tween.tween_property(gun_fire1, "modulate:a", 0, 0.5)
		tween.tween_property(gun_fire2, "modulate:a", 0, 0.5)
