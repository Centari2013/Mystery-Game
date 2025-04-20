extends ColorRect

@onready var shader_material := material as ShaderMaterial  # Replace Sprite2D with your node

func _process(delta: float):
	# Increment time for smooth animation
	shader_material.set_shader_parameter("time", Time.get_ticks_usec() / 1_000_000.0)
