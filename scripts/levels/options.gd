extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

@onready var button_bloom: Button = $ButtonBloom
@onready var button_blur: Button = $ButtonBlur
@onready var button_chromatic: Button = $ButtonChromatic
@onready var button_back: Button = $ButtonBack
@onready var label_back: Label = $ButtonBack/LabelBack

var bloom_active = true
var blur_active = true

const FONT_SIZE_NORMAL := 32
const FONT_SIZE_HOVER  := 42
const COLOR_NORMAL := Color.WHITE
const COLOR_HOVER  := Color.GREEN

func _ready() -> void:
	animation_player.play_backwards("fade")

# Set color and font size on hover
func on_hover(label: Label) -> void:
	label.label_settings.font_size = FONT_SIZE_HOVER
	label.label_settings.font_color = COLOR_HOVER

# Set normal color and font size
func on_exit(label: Label) -> void:
	label.label_settings.font_size = FONT_SIZE_NORMAL
	label.label_settings.font_color = COLOR_NORMAL

# Change button appearence and Bloom activity
func _on_button_bloom_pressed() -> void:
	if Global.bloom_active:
		button_bloom.modulate = Color(1, 1, 1)
		Global.bloom_active = false
	else:
		button_bloom.modulate = Color(0, 1, 0)
		Global.bloom_active = true

# Change button appearence and Blur activity
func _on_button_blur_pressed() -> void:
	if Global.blur_active:
		button_blur.modulate = Color(1, 1, 1)
		Global.blur_active = false
	else:
		button_blur.modulate = Color(0, 1, 0)
		Global.blur_active = true

# Change button appearence and Ca activity
func _on_button_chromatic_pressed() -> void:
	if Global.ca_active:
		button_chromatic.modulate = Color(1, 1, 1)
		Global.ca_active = false
	else:
		button_chromatic.modulate = Color(0, 1, 0)
		Global.ca_active = true

# Apply color and font changes / Active fade to next scene
func _on_button_back_mouse_entered() -> void: on_hover(label_back)
func _on_button_back_mouse_exited() -> void: on_exit(label_back)
func _on_button_back_pressed() -> void:
	animation_player.play("fade")
	await get_tree().create_timer(1).timeout
	await get_tree().process_frame
	get_tree().change_scene_to_file("res://scenes/levels/menu.tscn")
