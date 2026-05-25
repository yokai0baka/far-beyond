extends Node

# Detection variables control
var in_enemy_range = false
var apply_kill_effect = false
var end_game = false

# Points
var time = 0
var score = 0
var high_score = 0

# Options control
var bloom_active = true
var blur_active = true
var ca_active = true

func _process(delta: float) -> void:
	check_score()
	time += delta

# Manage score and highscore values
func check_score():
	if score > high_score:
		high_score = score
	else:
		score = score

func return_music():
	if end_game:
		MusicMenu.play()
