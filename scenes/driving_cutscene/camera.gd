extends Camera2D

@export var camera_speed = 150  # Speed at which the camera moves

func _ready():
	pass

func _process(delta):
	global_position.x += camera_speed * delta  # Move the camera right
