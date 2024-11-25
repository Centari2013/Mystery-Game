extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Khalil_Sleeping.play()
	$Amir_Sleeping.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
