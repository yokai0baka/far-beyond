extends CharacterBody2D
class_name Player

# Effects on screen...
@onready var animation_rainbow: AnimationPlayer = $AnimatedSprite2D/AnimationRainbow
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var cassino_animation: AnimationPlayer = $Camera2D/CassinoEffect/CassinoAnimation
@onready var end_animation: AnimationPlayer = $Camera2D/EndScreen/EndAnimation

# Audios...
@onready var kill_audio: AudioStreamPlayer2D = $Camera2D/CassinoEffect/KillAudio

# Labels HUD...
@onready var label_score: Label = $Camera2D/HUD/LabelScore
@onready var label_time: Label = $Camera2D/HUD/LabelTime
@onready var highscore_end: Label = $Camera2D/EndScreen/HighscoreEnd
@onready var run_time_end: Label = $Camera2D/EndScreen/RunTimeEnd

var SPEED = 250.0

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
	label_score.text = "SCORE: " + str(Global.score)
	label_time.text = str(roundi(Global.time))
	highscore_end.text = "SCORE: " + str(Global.score)
	run_time_end.text = "Time: " + str(roundi(Global.time))
	#cassino_label = randi_range(1, 3)
	kill()
	
	if Global.end_game:
		MusicInGameCalm.stop()
		MusicInGameAction.stop()
		set_physics_process(false)
		end_animation.play("close")
		await get_tree().create_timer(5).timeout
		end_animation.pause()
		
		if Input.is_action_just_pressed("Reset"):
			get_tree().change_scene_to_file("res://scenes/levels/menu.tscn")

# Check Global var and apply kill efects
func kill():
	if Global.apply_kill_effect:
		Global.check_effect()
		frenzy(0.5)
		play_cassino_label(randi_range(1, 3))
		kill_audio.play()
		animation_player.play("taunt")
		animation_rainbow.play("rainbow")
		Global.apply_kill_effect = false

# Change player SPEED on kill
func frenzy(amount: float) -> void:
	SPEED += 250.0 * amount
	if SPEED >= 450.0:
		SPEED = 450.0
	await get_tree().create_timer(4).timeout
	SPEED = 250.0

# Change music volume
func inAction():
	MusicInGameCalm.volume_db = -80.0
	MusicInGameAction.volume_db = 0.0

func outOffAction():
	MusicInGameCalm.volume_db = 0.0
	MusicInGameAction.volume_db = -80.0

# Sort kill labels
func play_cassino_label(cassino_label: int) -> void:
	cassino_label = randi_range(1, 3)
	cassino_animation.stop()
	cassino_animation.play("jackpot" + str(cassino_label))
