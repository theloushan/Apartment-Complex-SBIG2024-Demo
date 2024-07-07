extends Node

signal newDist
signal updateDist

var childNodes: Array # = get_tree().get_nodes_in_group("Distractions")
var activeNodes: Array
var targetNode: Button = null
var otState: bool = false
var dwState: bool = false
var checkStatus: bool = false
var totalActive: int = 0
var allTrue: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	# var gameNode = get_node("Gameplay")
	# gameNode.sendDistraction.connect(_on_send_distraction)
	childNodes = get_tree().get_nodes_in_group("Distractions")
	activeNodes.resize(childNodes.size())
	for i in range(0,childNodes.size()):
		activeNodes[i] = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_send_distraction(sentID):
	#print("targetting distraction #" + str(sentID))
	targetNode = childNodes[sentID]
	otState = targetNode.get_meta("isOneTime")
	dwState = targetNode.get_meta("dealtWith")
	#print("otState = " + str(otState))
	#print("dwState = " + str(dwState))
	
	if otState == true && dwState == true:
		#print("new dist needed, emitting signal")
		newDist.emit()
	else:
		#print("calling Distraction" + str(sentID) + "_activate_distraction")
		targetNode._activate_distraction()
		#print("setting activeNodes status")
		activeNodes[sentID] = true
		#print("activeNodes[" + str(sentID) + "] set to " + str(activeNodes[sentID]))
		#totalActive += 1


func _get_status(checkID):
	if activeNodes[checkID] == true:
		checkStatus = true
	else:
		checkStatus = false
	#print("activeNodes[" + str(checkID) + "] has a checkStatus of " + str(checkStatus))


func _on_active_state(stateBool,idNum):
	#var currentActive: int = totalActive
	#print("active state signal received, running Distraction Nodes._on_active_state")
	#print("stateBool is " + str(stateBool))
	#print("idNum is " + str(idNum))
	#print("totalActive before processing = " + str(totalActive))
	if stateBool == true:
		#print("processing stateBool as true")
		totalActive += 1
		#print("totalActive has added 1")
	elif stateBool == false:
		#print("processing stateBool as false")
		totalActive -= 1
		#print("totalActive has subtracted 1")
		#activeNodes[idNum] = false
	if totalActive <= 0:
		#print("safety check - totalActive is " + str(totalActive))
		totalActive = 0
		#print("safety check - totalActive set to " + str(totalActive))
	#print("totalActive is now " + str(totalActive))
	#print("emitting updateDist signal")
	emit_signal("updateDist",totalActive)
	#if currentActive != totalActive:
	#	totalActive = currentActive
	#	emit_signal("updateDist",totalActive)


func _check_for_false():
	allTrue = true
	for i in range(0,activeNodes.size()):
		if activeNodes[i] == false:
			allTrue = false
