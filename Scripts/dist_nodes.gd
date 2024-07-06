extends Node

signal newDist

var childNodes: Array # = get_tree().get_nodes_in_group("Distractions")
var targetNode: Button = null
var otState: bool = false
var dwState: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	# var gameNode = get_node("Gameplay")
	# gameNode.sendDistraction.connect(_on_send_distraction)
	childNodes = get_tree().get_nodes_in_group("Distractions")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_send_distraction(sentID):
	targetNode = childNodes[sentID]
	otState = targetNode.get_meta("isOneTime")
	dwState = targetNode.get_meta("dealtWith")
	
	if otState == true && dwState == true:
		newDist.emit()
	else:
		targetNode._activate_distraction()
