extends Node2D

@onready var player = $Detective  # Reference to the player
@onready var fade = $BlackFade/ColorRect  # Reference to the fade ColorRect
@onready var dialogue_box = $DialogueBox  # Reference to the dialogue box


func _ready() -> void:
	start_cutscene()
# Called to start the cutscene
func start_cutscene() -> void:
	player.cutscene_mode = true  # Disable player input
	fade_in_from_black()
	await get_tree().create_timer(3).timeout  # Wait for fade-in to complete
	move_player_to(Vector2(371, 421))  # Instantly position player
	await make_player_walk_to(Vector2(371, 254))  # Simulate walking
	player.cutscene_mode = false  # Re-enable player input


# Simulates player walking using the player's movement script
func make_player_walk_to(target_position: Vector2) -> void:
	while player.global_position.distance_to(target_position) > 2:
		var direction = (target_position - player.global_position).normalized()
		player.cutscene_move(direction)  # Use the player's movement logic
		await get_tree().process_frame  # Wait for the next frame
	player.cutscene_move(Vector2.ZERO)  # Stop moving

# Fades in from black
func fade_in_from_black() -> void:
	fade.visible = true
	fade.modulate = Color(0, 0, 0, 1)  # Fully opaque
	var tween = fade.create_tween()
	tween.tween_property(fade, "modulate:a", 0, 3)  # Fade to transparent over 1 second
	await tween.finished  # Wait for the tween to complete

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

# Shows dialogue with the Dialogue Manager (assumes dialogue manager is connected)
func show_dialogue(character_name: String, text: String) -> void:
	dialogue_box.start_dialogue(character_name, text)
