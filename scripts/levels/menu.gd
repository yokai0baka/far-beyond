extends Node2D

@onready var label_start: Label = $ButtonStart/Label
@onready var label_options: Label = $ButtonOptions/Label
@onready var label_credits: Label = $ButtonCredits/Label

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

func _on_button_start_mouse_entered():   on_hover(label_start)
func _on_button_start_mouse_exited():    on_exit(label_start)

func _on_button_options_mouse_entered(): on_hover(label_options)
func _on_button_options_mouse_exited():  on_exit(label_options)

func _on_button_credits_mouse_entered(): on_hover(label_credits)
func _on_button_credits_mouse_exited():  on_exit(label_credits)
