extends CharacterBody2D
class_name Enemy

func _physics_process(_delta: float) -> void:
	move_and_slide()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if "Player" in body.name:
		Global.in_enemy_range = true
		check_attack()

func _on_area_2d_body_exited(_body: Node2D) -> void:
	Global.in_enemy_range = false

func check_attack():
	Global.score += 100
	Global.apply_kill_effect = true
	self.queue_free()
