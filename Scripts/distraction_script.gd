extends Button

var dwState: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _activate_distraction():
	disabled = false
	$"Distraction Sprite".play()
	$"Distraction SFX".play(0)

func _toggled(toggled_on):
	if dwState == false:
		set_meta("dealtWith",true)
		dwState = true
	disabled = true
	$"Distraction Sprite".stop()
	$"Distraction Sprite".set_frame_and_progress(0,0)
	$"Distraction SFX".stop()
