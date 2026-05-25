extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _on_area_2d_body_entered(body: Node2D) -> void:
	if "Player" in body.name:
		animation_player.play("fade")
		await get_tree().create_timer(1).timeout
		await get_tree().process_frame
		get_tree().change_scene_to_file("res://scenes/levels/stage_002.tscn")
