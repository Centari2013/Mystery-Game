extends Area2D
@onready var icon = $icon
@export var player_here: bool = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_body_entered(body: Node2D) -> void:
	if body.name == "Detective" and not player_here:
		player_here = true
		%Detective.dialogue_mode = true
	
		Dialogic.start("front_door")
		await Dialogic.timeline_ended
	
		%Detective.dialogue_mode = false  # enable player input
	

	
	


func _on_body_exited(body: Node2D) -> void:
	player_here = false



	
