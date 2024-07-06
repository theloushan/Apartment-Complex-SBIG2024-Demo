extends Button

var dwState: bool = false
var idleName: String
var activeName: String

# Called when the node enters the scene tree for the first time.
func _ready():
	idleName = get_meta("animName") + "Idle"
	activeName = get_meta("animName") + "Active"
	$"Distraction Sprite".stop()
	$"Distraction Sprite".set_animation(idleName)
	$"Distraction Sprite".play()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _activate_distraction():
	disabled = false
	$"Distraction Sprite".stop()
	$"Distraction Sprite".set_animation(activeName)
	$"Distraction Sprite".play()
	$"Distraction SFX".play(0)

func _toggled(toggled_on):
	if dwState == false:
		set_meta("dealtWith",true)
		dwState = true
	disabled = true
	$"Distraction Sprite".stop()
	$"Distraction Sprite".set_animation(idleName)
	$"Distraction Sprite".play()
	$"Distraction SFX".stop()
