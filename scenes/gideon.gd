extends CharacterBody2D

@export var speed = 100  # How fast the player moves in pixels/second
var cutscene_mode = false  # toggle for cutscene mode
var dialogue_mode = false # toggle for dialogue mode
var movement_direction = Vector2.ZERO  # Player movement vector

func _ready():
	pass

func _physics_process(delta):
	if not cutscene_mode and not dialogue_mode:  
		# Only allow manual input if not in cutscene or dialoguey mode
		movement_direction = Vector2.ZERO

		# Normalize direction to prevent faster diagonal movement
		if movement_direction != Vector2.ZERO:
			movement_direction = movement_direction.normalized()
	
	if not dialogue_mode: # stop movement during regular
		# Set velocity and move
		velocity = movement_direction * speed
		move_and_slide()  # Moves the CharacterBody2D based on its velocity
	else:
		$AnimatedSprite2D.stop()
		
		
	# Animation handling
	if velocity.length() > 0:
		$AnimatedSprite2D.play()
		if velocity.x != 0:
			$AnimatedSprite2D.animation = "walk_right"
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
