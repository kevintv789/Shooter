extends CharacterBody2D

const SPEED: int = 500
const LASER_COOLDOWN: float = 0.5
const GRENADE_COOLDOWN: float = 2.0

var can_laser: bool = true
var can_grenade: bool = true

# Signals
signal player_laser_shot(position: Vector2, direction: Vector2)
signal player_grenade_shot(position: Vector2, direction: Vector2)

func _process(_delta: float):
	# Movement direction - negative x is left, positive x is right, negative y is up, positive y is down
	var direction = Input.get_vector("left", "right", "up", "down")

	# Because we're using move_and_slide, we need to set the velocity as velocity is default 0
	# Otherwise the player won't move
	velocity = direction * SPEED
	move_and_slide()

	# Rotate player
	look_at(get_global_mouse_position())


	# Calculate direction from grenade to mouse position
	# We normalize the direction to get a unit vector
	var player_direction = (get_global_mouse_position() - position).normalized()

	# Shooting input
	if Input.is_action_pressed("primary action") and can_laser:
		# Randomly select a marker 2D for the laser starting point
		var laser_markers = $LaserStartPositions.get_children()
		var laser_position = laser_markers[randi() % laser_markers.size()].global_position

		$LaserTimer.start(LASER_COOLDOWN)
		can_laser = false

		# Play laser particle
		$LaserParticle.emitting = true

		# Emit signal to other scenes
		player_laser_shot.emit(laser_position, player_direction)

	# Grenade input
	if Input.is_action_pressed("secondary action") and can_grenade:
		var selected_grenade = $GrenadeStartPositions.get_children()
		var player_position = selected_grenade[0].global_position

		$GrenadeTimer.start(GRENADE_COOLDOWN)
		can_grenade = false

		player_grenade_shot.emit(player_position, player_direction)

# When the timer times out, we can shoot again
func _on_timer_timeout() -> void:
	can_laser = true


func _on_grenade_timer_timeout() -> void:
	can_grenade = true
