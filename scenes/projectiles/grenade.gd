extends RigidBody2D

const SPEED = 750
var explosion_active: bool = false
var explosion_radius: int = 200
var damage: int = 20

func _ready():
	$Explosion.hide()

func explode():
	$Explosion.show()
	$AnimationPlayer.play("Explosion")
	explosion_active = true

func _process(_delta: float) -> void:
	if explosion_active:
		explosion_active = false
		var entity_group = get_tree().get_nodes_in_group("Entity")
		var container_group = get_tree().get_nodes_in_group("Container")
		var targets = entity_group + container_group
		for target in targets:
			# Gets the distance between the grenade and the target
			var dist_to_target = target.global_position.distance_to(global_position)
			var in_range = dist_to_target < explosion_radius

			if "hit" in target and in_range:
				target.hit(damage)
