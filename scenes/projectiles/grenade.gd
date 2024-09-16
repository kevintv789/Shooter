extends RigidBody2D

const SPEED = 750

func _ready():
	$Explosion.hide()

func explode():
	$Explosion.show()
	$AnimationPlayer.play("Explosion")
