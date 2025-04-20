extends Sprite2D

@export var target_position: Vector2 = Vector2(22, 114)
@export var speed: float = 200  # Pixels per second

func _process(delta):
	pass

func move_sprite(t_pos: Vector2):
	while position != t_pos:
		var delta = get_physics_process_delta_time()
		position = position.move_toward(t_pos, speed * delta)
		await get_tree().process_frame  # Wait for the next frame
