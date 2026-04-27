extends Node

@onready var bloom: WorldEnvironment = $Bloom
@onready var blur: ColorRect = $Blur
@onready var ca: ColorRect = $ChromaticAberration

# Change VFX visibility
func _process(_delta: float) -> void:
	if Global.bloom_active:
		bloom.environment.glow_bloom = true
	else:
		bloom.environment.glow_bloom = false

	if Global.blur_active:
		blur.visible = true
	else:
		blur.visible = false

	if Global.ca_active:
		ca.visible = true
	else:
		ca.visible = false
