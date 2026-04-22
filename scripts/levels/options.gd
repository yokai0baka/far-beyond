extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

@onready var button_bloom: Button = $ButtonBloom
@onready var button_blur: Button = $ButtonBlur
@onready var button_back: Button = $ButtonBack
@onready var label_back: Label = $ButtonBack/LabelBack

var bloom_active = true
var blur_active = true

const FONT_SIZE_NORMAL := 32
const FONT_SIZE_HOVER  := 42
const COLOR_NORMAL := Color.WHITE
const COLOR_HOVER  := Color.GREEN

func on_hover(label: Label) -> void:
	label.label_settings.font_size = FONT_SIZE_HOVER
	label.label_settings.font_color = COLOR_HOVER

func on_exit(label: Label) -> void:
	label.label_settings.font_size = FONT_SIZE_NORMAL
	label.label_settings.font_color = COLOR_NORMAL

func _on_button_bloom_pressed() -> void:
	if Global.bloom_active:
		button_bloom.modulate = Color(1, 1, 1)
		Global.bloom_active = false
	else:
		button_bloom.modulate = Color(0, 1, 0)
		Global.bloom_active = true

func _on_button_blur_pressed() -> void:
	if Global.blur_active:
		button_bloom.modulate = Color(1, 1, 1)
		Global.blur_active = false
	else:
		button_bloom.modulate = Color(0, 1, 0)
		Global.blur_active = true

func _on_button_back_mouse_entered() -> void: on_hover(label_back)
func _on_button_back_mouse_exited() -> void: on_exit(label_back)
func _on_button_back_pressed() -> void:
	animation_player.play("fade")
	await get_tree().create_timer(1).timeout
	await get_tree().process_frame
	get_tree().change_scene_to_file("res://scenes/levels/menu.tscn")
