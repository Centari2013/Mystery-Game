extends Sprite2D


func _ready() -> void:
	Dialogic.signal_event.connect(big_ass_hole)
	
func big_ass_hole(arg:String):
	match arg:
		"show":
			self.show()
		"hide":
			self.hide()
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
