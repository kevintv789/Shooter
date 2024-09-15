extends CharacterBody2D

const SPEED: int = 500
const LASER_COOLDOWN: float = 0.5
const GRENADE_COOLDOWN: float = 2.0

var can_laser: bool = true
var can_grenade: bool = true

# Signals
signal player_laser_shot(position: Vector2)
signal player_grenade_shot(position: Vector2)

func _process(_delta: float):
	# Movement direction - negative x is left, positive x is right, negative y is up, positive y is down
	var direction = Input.get_vector("left", "right", "up", "down")

	# Because we're using move_and_slide, we need to set the velocity as velocity is default 0
	# Otherwise the player won't move
	velocity = direction * SPEED
	move_and_slide()

	# Shooting input
	if Input.is_action_pressed("primary action") and can_laser:
		# Randomly select a marker 2D for the laser starting point
		var laser_markers = $LaserStartPositions.get_children()
		var selected_laser = laser_markers[randi() % laser_markers.size()]
		
		$LaserTimer.start(LASER_COOLDOWN)
		can_laser = false

		# Emit signal to other scenes
		player_laser_shot.emit(selected_laser.global_position)

	# Grenade input
	if Input.is_action_pressed("secondary action") and can_grenade:
		var selected_grenade = $GrenadeStartPositions.get_children()
		player_grenade_shot.emit(selected_grenade[0].global_position)
		$GrenadeTimer.start(GRENADE_COOLDOWN)
		can_grenade = false

# When the timer times out, we can shoot again
func _on_timer_timeout() -> void:
	can_laser = true


func _on_grenade_timer_timeout() -> void:
		can_grenade = true
