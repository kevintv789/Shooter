extends ItemContainer

func hit() -> void:
	if opened:
		return

	$LidSprite.hide()
	var pos = $SpawnPositions.get_child(randi()% $SpawnPositions.get_child_count()).global_position
	lid_opened.emit(pos, current_direction)

	opened = true
