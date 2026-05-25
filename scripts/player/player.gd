extends CharacterBody2D
class_name Player

# Effects and labels...
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var cassino_animation: AnimationPlayer = $Camera2D/CassinoEffect/CassinoAnimation
@onready var end_animation: AnimationPlayer = $Camera2D/EndScreen/EndAnimation

# Audios...
@onready var kill_audio: AudioStreamPlayer2D = $Camera2D/CassinoEffect/KillAudio

var SPEED = 250.0

var cassino_label = randi_range(1, 3)

# Player movement
func _physics_process(_delta: float) -> void:
	var direction := Input.get_vector("Left", "Right", "Up", "Down").normalized()
	if direction.x:
		velocity.x = direction.x * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if direction.y:
		velocity.y = direction.y * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
	
	if velocity.x:
		$AnimatedSprite2D.flip_h = velocity.x > 0

	move_and_slide()

func _process(_delta: float) -> void:
	$Camera2D/HUD/LabelScore.text = "SCORE: " + str(Global.score)
	$Camera2D/HUD/LabelTime.text = str(roundi(Global.time))
	$Camera2D/EndScreen/HighscoreEnd.text = "SCORE: " + str(Global.score)
	$Camera2D/EndScreen/RunTimeEnd.text = "Time: " + str(roundi(Global.time))
	cassino_label = randi_range(1, 3)
	kill()
	
	if Global.end_game:
		MusicInGame.stop()
		set_physics_process(false)
		end_animation.play("close")
		await get_tree().create_timer(5).timeout
		end_animation.pause()
		
		if Input.is_action_just_pressed("Reset"):
			get_tree().change_scene_to_file("res://scenes/levels/menu.tscn")

# Check Global var and apply kill efects
func kill():
	if Global.apply_kill_effect:
		frenzy()
		change_cassino_label()
		kill_audio.play()
		animation_player.play("taunt")
		Global.apply_kill_effect = false

# Change player SPEED on kill
func frenzy():
	SPEED = 300.0
	await get_tree().create_timer(2).timeout
	SPEED = 250.0

# Sort kill labels
func change_cassino_label():
	cassino_animation.stop()
	cassino_animation.play("jackpot" + str(cassino_label))
