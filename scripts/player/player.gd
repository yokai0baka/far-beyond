extends CharacterBody2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var audio_stream_player: AudioStreamPlayer2D = $AudioStreamPlayer2D

const SPEED = 100.0

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
	taunt()

func taunt():
	var cooldown = false
	if Input.is_action_just_pressed("Taunt") && !cooldown:
		animation_player.play("taunt")
		cooldown = true
		if cooldown:
			await get_tree().create_timer(6.0).timeout
			cooldown = false
