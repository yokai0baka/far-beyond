extends CharacterBody2D
class_name Enemy

@onready var animation_player: AnimationPlayer = $Killzone/AnimationPlayer

var player_in_range = false

func _physics_process(_delta: float) -> void:
	move_and_slide()

func _process(_delta: float) -> void:
	if player_in_range:
		self.animation_player.play("prepare_attack")
	else:
		self.animation_player.play("RESET")

# Read MF
func trigger_attack():
	Global.end_game = true

# If player in range trigger death
func _on_deathzone_body_entered(body: Node2D) -> void:
	if "Player" in body.name:
		Global.score += 1000
		Global.apply_kill_effect = true
		self.queue_free()

# If player in range trigger attack
func _on_killzone_body_entered(body: Node2D) -> void:
	if "Player" in body.name:
		player_in_range = true

# If player off range set vars to normal 
func _on_killzone_body_exited(_body: Node2D) -> void:
	player_in_range = false
