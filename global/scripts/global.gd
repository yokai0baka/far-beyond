extends Node

var in_enemy_range = false
var apply_kill_effect = false
var end_game = false

var time = 0
var score = 0
var high_score = 0

var bloom_active = true
var blur_active = true

func _process(delta: float) -> void:
	check_score()
	time += delta

func check_score():
	if score > high_score:
		high_score = score
	else:
		score = score
