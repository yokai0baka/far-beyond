extends Sprite2D

@onready var locked_door: Sprite2D = $"."
@onready var rigid_body_2d: RigidBody2D = $RigidBody2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Global.has_key:
		locked_door.visible = false
		rigid_body_2d.collision_layer = 0
	else:
		locked_door.visible = true
		rigid_body_2d.collision_layer = 1
