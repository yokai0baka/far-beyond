extends CharacterBody2D
class_name Enemy

func _physics_process(_delta: float) -> void:
	move_and_slide()
