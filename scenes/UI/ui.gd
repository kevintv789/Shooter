extends CanvasLayer

# Colors
var green_color: Color = Color("6bbfa3")
var red_color: Color = Color("ff4d4d")

@onready var laser_label: Label = $ProjectileCounter/LaserCounter/VBoxContainer/Label
@onready var grenade_label: Label = $ProjectileCounter/GrenadeCounter/VBoxContainer/Label
@onready var laser_icon: TextureRect = $ProjectileCounter/LaserCounter/VBoxContainer/TextureRect
@onready var grenade_icon: TextureRect = $ProjectileCounter/GrenadeCounter/VBoxContainer/TextureRect

# Preserve the laser and grenade amount when a new scene is loaded
func _ready() -> void:
	update_laser_amount()
	update_grenade_amount()

func update_laser_amount() -> void:
	laser_label.text = str(Globals.laser_amount)
	update_color()

func update_grenade_amount() -> void:
	grenade_label.text = str(Globals.grenade_amount)
	update_color()

func update_color() -> void:
	laser_label.modulate = green_color
	laser_icon.modulate = green_color
	grenade_label.modulate = green_color
	grenade_icon.modulate = green_color

	if laser_label.text == "0":
		laser_label.modulate = red_color
		laser_icon.modulate = red_color

	if grenade_label.text == "0":
		grenade_label.modulate = red_color
		grenade_icon.modulate = red_color
