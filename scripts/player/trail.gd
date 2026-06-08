extends Node

@onready var animated_sprite_2d: AnimatedSprite2D = $"../AnimatedSprite2D"
@onready var player: Player = $".."


func _process(_delta: float) -> void:
	if (get_tree().get_frame() % 6) == 0 && Global.trail_effect:
		var newSprite : AnimatedSprite2D = animated_sprite_2d.duplicate()
		newSprite.stop()
		newSprite.z_index = 0
		get_tree().root.add_child(newSprite)
		newSprite.global_position = player.global_position + animated_sprite_2d.position
		newSprite.StartFading()
