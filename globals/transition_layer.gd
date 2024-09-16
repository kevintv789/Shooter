extends CanvasLayer

@onready var color_rect: ColorRect = $ColorRect

func _ready() -> void:
	if color_rect:
		color_rect.visible = false

func change_scene(target: PackedScene) -> void:
	color_rect.visible = true
	$FadeToBlack.play("fade_to_black")
	await $FadeToBlack.animation_finished
	get_tree().change_scene_to_packed(target)
	$FadeToBlack.play_backwards("fade_to_black")
	
