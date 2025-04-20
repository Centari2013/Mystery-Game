extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var variables = Dialogic.VAR.get('detective_home')
	var called_gideon: bool = variables.get("called_gideon")
	var called_al: bool = variables.get("called_al")
	
	var car: Sprite2D = $Camera2D/Detective_Car
	var motorcycle: AnimatedSprite2D = $Camera2D/Detective_Motorcycle
	
	if called_gideon and called_al:
		car.show()
		Dialogic.start_timeline("gideon_and_al")
		
	elif called_gideon:
		car.show()
		Dialogic.start_timeline("gideon")
		
	elif called_al:
		motorcycle.play()
		motorcycle.show()
		Dialogic.start_timeline("al")
	else:
		motorcycle.play()
		motorcycle.show()
		Dialogic.start_timeline("solo")
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
