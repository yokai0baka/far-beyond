extends Node2D

@onready var label_start: Label = $ButtonStart/Label
@onready var label_options: Label = $ButtonOptions/Label
@onready var label_credits: Label = $ButtonCredits/Label

@onready var highscore: Label = $Highscore

@onready var animation_player: AnimationPlayer = $AnimationPlayer

const FONT_SIZE_NORMAL := 32
const FONT_SIZE_HOVER  := 42
const COLOR_NORMAL := Color.WHITE
const COLOR_HOVER  := Color.GREEN

func _ready() -> void:
	Global.time = 0
	Global.end_game = false

func _process(_delta: float) -> void:
	highscore.text = "HIGHSCORE: " + str(Global.high_score)

func on_hover(label: Label) -> void:
	label.label_settings.font_size = FONT_SIZE_HOVER
	label.label_settings.font_color = COLOR_HOVER

func on_exit(label: Label) -> void:
	label.label_settings.font_size = FONT_SIZE_NORMAL
	label.label_settings.font_color = COLOR_NORMAL

func _on_button_start_mouse_entered():   on_hover(label_start)
func _on_button_start_mouse_exited():    on_exit(label_start)
func _on_button_start_pressed() -> void:
	animation_player.play("fade")
	await get_tree().create_timer(1).timeout
	await get_tree().process_frame
	get_tree().change_scene_to_file("res://scenes/levels/main.tscn")

func _on_button_options_mouse_entered(): on_hover(label_options)
func _on_button_options_mouse_exited():  on_exit(label_options)
func _on_button_options_pressed() -> void:
	animation_player.play("fade")
	await get_tree().create_timer(1).timeout
	await get_tree().process_frame
	get_tree().change_scene_to_file("res://scenes/levels/options.tscn")

func _on_button_credits_mouse_entered(): on_hover(label_credits)
func _on_button_credits_mouse_exited():  on_exit(label_credits)
func _on_button_credits_pressed() -> void:
	animation_player.play("fade")
	await get_tree().create_timer(1).timeout
	await get_tree().process_frame
	get_tree().change_scene_to_file("res://scenes/levels/credits.tscn")
