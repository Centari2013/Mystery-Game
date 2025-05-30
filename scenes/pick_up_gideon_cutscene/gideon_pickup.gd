extends Node2D

@onready var player = $Gideon  # Reference to the player
#@onready var fade = $BlackFade/ColorRect  # Reference to the fade ColorRect
@export var disable_cutscene: bool = false



func _ready() -> void:
	if not disable_cutscene:
		Dialogic.signal_event.connect(gideon_walk)
		start_cutscene()
	
func gideon_walk(arg: String):
	match arg:
		"gideon_walk":
			var sprite: AnimatedSprite2D = player.get_node("AnimatedSprite2D")
			player.cutscene_mode = true  # Disable player input
			sprite.animation = "walk_down"
			await make_player_walk_to(Vector2(0, 127))  # Simulate walking
			player.hide()
		

# Called to start the cutscene
func start_cutscene() -> void:
	$Car.move_sprite(Vector2(22, 114))
	await get_tree().create_timer(2).timeout
	play_dialogue()
	await Dialogic.timeline_ended
	$Car.move_sprite(Vector2(406, 114))
	player.cutscene_mode = false  # Re-enable player input
	SceneManager.load_scene("res://scenes/driving_cutscene/Driving_Cutscene.tscn")
	

# Simulates player walking using the player's movement script
func make_player_walk_to(target_position: Vector2) -> void:
	while player.global_position.distance_to(target_position) > 2:
		var direction = (target_position - player.global_position).normalized()
		player.cutscene_move(direction)  # Use the player's movement logic
		await get_tree().process_frame  # Wait for the next frame
	player.cutscene_move(Vector2.ZERO)  # Stop moving

"""
# Fades in from black
func fade_in_from_black() -> void:
	fade.visible = true
	fade.modulate = Color(0, 0, 0, 1)  # Fully opaque
	var tween = fade.create_tween()
	tween.tween_property(fade, "modulate:a", 0, 3)  # Fade to transparent over 1 second
	await tween.finished  # Wait for the tween to complete
"""
# Makes the player walk to a target position
func player_walks(target_position: Vector2) -> void:
	
	var tween = player.create_tween()
	tween.tween_property(player, "position", target_position, 1)  # Duration is 1 second
	tween.set_trans(Tween.TRANS_SINE)  # Transition type
	tween.set_ease(Tween.EASE_IN_OUT)  # Ease type
	await tween.finished  # Wait for the movement to complete

# Moves the player instantly to a position
func move_player_to(position: Vector2) -> void:
	player.position = position


# Plays a Dialogic timeline
func play_dialogue() -> void:
	# check if a dialog is already running
	if Dialogic.current_timeline != null:
		return
	Dialogic.Styles.load_style('main_style')
	Dialogic.start('pick_up_gideon')
	get_viewport().set_input_as_handled()
