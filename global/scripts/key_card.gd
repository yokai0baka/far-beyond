extends Sprite2D

@onready var key_card: Sprite2D = $"."

func _on_area_2d_body_entered(body: Node2D) -> void:
	if "Player" in body.name:
		Global.has_key = true
		key_card.visible = false
