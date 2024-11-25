extends Area2D
@onready var icon = $icon
@export var player_here: bool = false
@export var file_path: String
var interacion_triggered = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player_here and not interacion_triggered:
		if Input.is_action_just_pressed("interact"):
			interacion_triggered = true
			icon.hide()
			%Detective.dialogue_mode = true
			
			var timeline = create_timeline()
			if timeline != null:
				timeline.events_processed = true
				Dialogic.start(timeline)
				await Dialogic.timeline_ended
			else:
				print("Unable to start null timeline.")
			%Detective.dialogue_mode = false  # enable player input
			icon.show()
		interacion_triggered = false


func create_timeline() -> DialogicTimeline:
	var timeline : DialogicTimeline = DialogicTimeline.new()
	var file := FileAccess.open(file_path, FileAccess.READ)
	if file:
		# read in Dialogic timeline text
		var text = file.get_as_text()
		timeline.from_text(text)	
		file.close()
		
		timeline.process()
		return timeline
		
	else:
		print("Failed to open file: %s" % file_path)
		print("Is the File Path variable set?")
		return null


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Detective":
		player_here = true
		icon.animation = "pulse"
		icon.play()
		icon.show()
	
	


func _on_body_exited(body: Node2D) -> void:
	player_here = false
	icon.hide()
	icon.stop()
