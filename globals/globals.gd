extends Node

signal stats_changed()

var laser_amount: int = 20:
	get: 
		return laser_amount
	set(value):
		laser_amount = value
		stats_changed.emit()

var grenade_amount: int = 5:
	get:
		return grenade_amount
	set(value):
		grenade_amount = value
		stats_changed.emit()

var health: int = 70:
	get:
		return health
	set(value):
		health = value
		if health > 100:
			health = 100
		stats_changed.emit()
