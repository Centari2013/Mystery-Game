extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$VBoxContainer/SubViewportContainer/SubViewport.world_2d = $VBoxContainer/SubViewportContainer2/SubViewport.find_world_2d()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
