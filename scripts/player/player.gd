extends CharacterBody2D
class_name Player

@onready var animation_player: AnimationPlayer = $AnimationPlayer

const SPEED = 175.0

var in_range = false
var pressed_attack = false 

func _physics_process(_delta: float) -> void:
	var direction := Input.get_vector("Left", "Right", "Up", "Down")
	if direction.x:
		velocity.x = direction.x * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if direction.y:
		velocity.y = direction.y * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()

func _process(_delta: float) -> void:
	kill()
	$Camera2D/LabelScore.text = "SCORE: " + str(Global.score)
	$Camera2D/LabelTime.text = "Time: " + str(roundi(Global.time))

func kill():
	var cooldown = false
	if Global.in_enemy_range && !cooldown:
		Global.is_attacking = true
		animation_player.play("taunt")
		cooldown = true

		if cooldown:
			await get_tree().create_timer(5.0).timeout
			animation_player.play("idle")
			cooldown = false
