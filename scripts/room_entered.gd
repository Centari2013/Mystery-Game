extends Area2D

@export var player_here: bool = false # avoid recursion from area detecting body
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	# make player a child of current area for y_sort
	if body.name == "Detective" and not player_here:
		player_here = true # stop recursion
		print("Player detected: ", body.name)
		
		var global_position = body.global_position
		body.get_parent().remove_child(body)
		add_child(body)
		body.global_position = global_position
		print("Detective is now a child of ", body.get_parent().name)
		
		 
	


func _on_area_exited(area: Area2D) -> void:
	player_here = false
