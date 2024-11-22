extends CharacterBody2D

@export var speed = 150  # How fast the player moves in pixels/second
var cutscene_mode = false  # Toggle for cutscene mode
var movement_direction = Vector2.ZERO  # Player movement vector

func _ready():
	pass

func _physics_process(delta):
	if not cutscene_mode:  # Only allow manual input if not in cutscene mode
		movement_direction = Vector2.ZERO

		# Input handling
		if Input.is_action_pressed("move_right"):
			movement_direction.x += 1
		if Input.is_action_pressed("move_left"):
			movement_direction.x -= 1
		if Input.is_action_pressed("move_down"):
			movement_direction.y += 1
		if Input.is_action_pressed("move_up"):
			movement_direction.y -= 1

		# Normalize direction to prevent faster diagonal movement
		if movement_direction != Vector2.ZERO:
			movement_direction = movement_direction.normalized()

	# Set velocity and move
	velocity = movement_direction * speed
	move_and_slide()  # Moves the CharacterBody2D based on its velocity

	# Animation handling
	if velocity.length() > 0:
		$AnimatedSprite2D.play()
		if velocity.x != 0:
			$AnimatedSprite2D.animation = "walk_right"
			$AnimatedSprite2D.flip_v = false
			$AnimatedSprite2D.flip_h = velocity.x < 0
		elif velocity.y != 0:
			if velocity.y > 0:
				$AnimatedSprite2D.animation = "walk_down"
			else:
				$AnimatedSprite2D.animation = "walk_up"
	else:
		$AnimatedSprite2D.stop()

# Function to move the player in cutscene mode
func cutscene_move(direction: Vector2):
	movement_direction = direction.normalized()
