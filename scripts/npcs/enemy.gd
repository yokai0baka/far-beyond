extends CharacterBody2D
class_name Enemy

@onready var animation_player: AnimationPlayer = $Killzone/AnimationPlayer
@onready var animation_label: AnimationPlayer = $Killzone/AnimationLabel

# Bullet sprite
@onready var bullet: CharacterBody2D = $Bullet

# Labels
@onready var warning_label: Label = $Killzone/WarningLabel
@onready var searching_label: Label = $Killzone/SearchingLabel
@onready var attack_label1: Label = $Killzone/AttackLabel
@onready var attack_label2: Label = $Killzone/AttackLabel2
@onready var attack_label3: Label = $Killzone/AttackLabel3

var player_in_range = false
var attack_labels = randi_range(1, 3)

func _ready() -> void:
	bullet.visible = false

func _physics_process(_delta: float) -> void:
	move_and_slide()

func _process(_delta: float) -> void:
	if player_in_range:
		self.animation_player.play("prepare_attack")
	else:
		self.animation_player.play("RESET")

	if Global.end_game:
		set_physics_process(false)
		await get_tree().create_timer(4.0).timeout
		animation_label.play("RESET")

func change_attack_label():
	match attack_labels:
		1:
			self.attack_label1.visible = true
		2:
			self.attack_label2.visible = true
		3:
			self.attack_label3.visible = true

# Trigger end game global var
func trigger_attack():
	Global.end_game = true
	change_attack_label()
	self.warning_label.visible = false
	self.bullet.shoot()

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
		self.warning_label.visible = true

# If player off range set vars to normal 
func _on_killzone_body_exited(_body: Node2D) -> void:
	player_in_range = false
	self.warning_label.visible = false
	self.searching_label.visible = true
	await get_tree().create_timer(6.0).timeout
	self.searching_label.visible = false
