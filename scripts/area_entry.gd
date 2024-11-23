extends Area2D

@export var player_here: bool = false # avoid recursion from area detecting body
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	connect("body_entered", Callable(self, "_on_body_entered"))
	connect("body_exited", Callable(self, "_on_body_exited"))



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	# make player a child of current area for y_sort
	if body.name == "Detective" and not player_here:
		player_here = true 
		print("Player detected: ", body.name)
		hide_children(self, false)


func _on_body_exited(body: Node2D) -> void:
	player_here = false 
	print("Player left area: ", self.name)
	hide_children(self, true)
	

func hide_children(area: Area2D, hide: bool) -> void:
	if hide:
		for c in area.get_children():
			if c != $HideOverlay:  # Check if the child is NOT the specific node
				c.hide()
			$HideOverlay.show()
	else:
		for c in area.get_children():
			if c != $HideOverlay:
				c.show()
			$HideOverlay.hide()
