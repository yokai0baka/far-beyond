extends Camera2D

@export var random_strenght: float = 30.0 # Force duh...
@export var shake_fade: float = 5.0 # Values higher -> Fade faster...

var shake_strenght: float = 0.0
var rng = RandomNumberGenerator.new()

func apply_shake():
	shake_strenght = random_strenght

func _process(delta: float) -> void:
	if shake_strenght > 0:
		shake_strenght = lerpf(shake_strenght, 0, shake_fade * delta)

		offset = random_offset()

	if Global.apply_kill_effect:
		apply_shake()
		await get_tree().create_timer(0.25).timeout
		Global.apply_kill_effect = false

func random_offset() -> Vector2:
	return Vector2(rng.randf_range(-shake_strenght, shake_strenght), rng.randf_range(-shake_strenght, shake_strenght))
