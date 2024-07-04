extends Node

signal newDist

var childNodes = get_tree().get_nodes_in_group("Distractions")
var targetNode: Button = null
var otState: bool = false
var dwState: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	# var gameNode = get_node("Gameplay")
	# gameNode.sendDistraction.connect(_on_send_distraction)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_send_distraction(sentID):
	targetNode = childNodes[sentID]
	otState = targetNode.get_meta("Is_One_Time")
	dwState = targetNode.get_meta("Dealt_With")
	
	if otState == true && dwState == true:
		newDist.emit()
	else:
		targetNode._activate_distraction()
