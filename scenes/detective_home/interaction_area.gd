extends Area2D
@onready var icon = $icon
@export var player_here: bool = false
var interacion_triggered = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player_here and not interacion_triggered:
		interacion_triggered = true
		if Input.is_action_just_pressed("interact"):
			%Detective.cutscene_mode = true
			Dialogic.start('broken_table')
			await Dialogic.timeline_ended
			%Detective.cutscene_mode = false  # enable player input
		interacion_triggered = false


func _on_body_entered(body: Node2D) -> void:
	player_here = true
	if body.name == "Detective":
		icon.animation = "pulse"
		icon.play()
		icon.show()
	
	


func _on_body_exited(body: Node2D) -> void:
	player_here = false
	icon.hide()
	icon.stop()
