extends CharacterBody2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var sprite_2d_2: Sprite2D = $Sprite2D2
@onready var player: Player = $"../../../Player"

var SPEED = 0.0

func shoot():
	SPEED = 350.0

func _physics_process(_delta):
	if player:
		var direction = global_position.direction_to(player.global_position)
		velocity = direction * SPEED
		look_at(player.global_position)
	else:
		velocity = Vector2.ZERO
	
	move_and_slide()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if "Player" in body.name:
		self.sprite_2d.visible = false
