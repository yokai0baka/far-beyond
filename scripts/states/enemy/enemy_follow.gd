extends State
class_name EnemyFollow

@export var enemy: CharacterBody2D
@export var move_speed: = 100.0
@onready var sprite_2d: Sprite2D = $"../../Sprite2D"

var player: CharacterBody2D

func enter():
	player = get_tree().get_first_node_in_group("Player")

func physics_update(_delta: float):
	var direction = player.global_position - enemy.global_position
	
	if direction.length() > 25:
		enemy.velocity = direction.normalized() * move_speed
	else:
		enemy.velocity = Vector2()

	if direction.length() > 150:
		Transitioned.emit(self, "Idle")

	if direction.x:
		sprite_2d.flip_h = direction.x < 0
