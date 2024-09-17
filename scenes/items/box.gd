extends ItemContainer

func hit(_damage: int) -> void:
	if opened:
		return

	$LidSprite.hide()

	# Spawns 3 items per box
	for i in range(3):
		var pos = $SpawnPositions.get_child(randi()% $SpawnPositions.get_child_count()).global_position
		lid_opened.emit(pos, current_direction)

	opened = true
