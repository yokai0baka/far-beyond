extends CharacterBody2D
class_name Enemy

func _physics_process(_delta: float) -> void:
	move_and_slide()

func _process(_delta: float) -> void:
	check_attack()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if "Player" in body.name:
		Global.in_enemy_range = true

func check_attack():
	if Global.check_attack:
		queue_free()
