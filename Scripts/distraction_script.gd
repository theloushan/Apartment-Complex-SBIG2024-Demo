extends Button

signal activeState

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
	#if get_meta("animName") == "window":
	#	$"Distraction Sprite".set_frame_and_progress(4,4)
	#	$"Distraction Sprite".pause()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _activate_distraction():
	#print("running _activate_distraction()")
	disabled = false
	#print("disabled set to " + str(disabled))
	$"Distraction Sprite".stop()
	#print("animation stopped")
	$"Distraction Sprite".set_animation(activeName)
	#print("animation set to " + activeName)
	$"Distraction Sprite".play()
	#print("playing animation")
	$"Distraction SFX".play(0)
	#print("playing sfx")
	#print("emitting activeState signal with status of true")
	activeState.emit(true,get_meta("distID"))

func _toggled(toggled_on):
	if dwState == false:
		set_meta("dealtWith",true)
		dwState = true
	disabled = true
	#set_pressed(false)
	$"Distraction Sprite".stop()
	$"Distraction Sprite".set_animation(idleName)
	$"Distraction Sprite".play()
	$"Distraction SFX".stop()
	emit_signal("activeState",false,get_meta("distID"))
	#if get_meta("animName") == "window":
	#	$"Distraction Sprite".set_frame_and_progress(5,5)
	#	$"Distraction Sprite".pause()
