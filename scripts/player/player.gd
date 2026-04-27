extends CharacterBody2D
class_name Player

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var cassino_animation: AnimationPlayer = $Camera2D/CassinoEffect/CassinoAnimation
@onready var end_animation: AnimationPlayer = $Camera2D/EndScreen/EndAnimation
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
	$Camera2D/HUD/LabelScore.text = "SCORE: " + str(Global.score)
	$Camera2D/HUD/LabelTime.text = "Time: " + str(roundi(Global.time))
	kill()
	
	if Global.end_game:
		set_physics_process(false)
		end_animation.play("close")
		await get_tree().create_timer(5).timeout
		end_animation.pause()
		
		if Input.is_action_just_pressed("Reset"):
			get_tree().change_scene_to_file("res://scenes/levels/menu.tscn")

func kill():
	if Global.apply_kill_effect:
		animation_player.play("taunt")
		cassino_animation.play("jackpot1")
		Global.apply_kill_effect = false
		if cassino_animation.is_playing():
			cassino_animation.play("jackpot2")
