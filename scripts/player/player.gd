extends CharacterBody2D
class_name Player

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var camera_2d: Camera2D = $Camera2D

const SPEED = 175.0

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
	$Camera2D/LabelScore.text = "SCORE: " + str(Global.score)
	$Camera2D/LabelTime.text = "Time: " + str(roundi(Global.time))
	kill()

func kill():
	if Global.apply_kill_effect:
		animation_player.play("taunt")
