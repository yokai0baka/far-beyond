extends CharacterBody2D
class_name Enemy

var kill_cooldown = 1
var player_in_range = false

func _physics_process(_delta: float) -> void:
	move_and_slide()

func _process(delta: float) -> void:
	if player_in_range:
		kill_cooldown -= 1 * delta
		if kill_cooldown <= 0:
			Global.end_game = true
	else:
		kill_cooldown = 1

func _on_area_2d_body_entered(body: Node2D) -> void:
	if "Player" in body.name:
		Global.in_enemy_range = true
		check_attack()

func _on_area_2d_body_exited(_body: Node2D) -> void:
	Global.in_enemy_range = false

func check_attack():
	Global.score += 1000
	Global.apply_kill_effect = true
	self.queue_free()

func _on_killzone_body_entered(body: Node2D) -> void:
	if "Player" in body.name:
		player_in_range = true

func _on_killzone_body_exited(_body: Node2D) -> void:
	player_in_range = false
	kill_cooldown = 4
