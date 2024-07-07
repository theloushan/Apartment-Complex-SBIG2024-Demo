extends Node

# signal sendDistraction

var distArray: Array # = get_tree().get_nodes_in_group("Distractions")
var distCount: int = 0
var chosenDist: int = 0
var groupNode: Node = null
var timeString: String
var addScore: int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	distArray = get_tree().get_nodes_in_group("Distractions")
	distCount = distArray.size()
	groupNode = get_node("Distraction Nodes")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_d_timer_timeout():
	chosenDist = randi() % distCount
	$"Distraction Nodes"._check_for_false()
	if $"Distraction Nodes".allTrue == false:
		var distConfirm = false
		while distConfirm == false:
			#print("calling Distraction Nodes._get_status(" + str(chosenDist) + ")")
			$"Distraction Nodes"._get_status(chosenDist)
			if $"Distraction Nodes".checkStatus == true:
				#print("checkStatus is true, choosing new dist")
				distConfirm = false
				chosenDist = randi() % distCount
				#print("new chosen dist is " + str(chosenDist))
			else:
				#print("checkStatus is false, using chosen dist")
				distConfirm = true
		#print("calling Distraction Nodes._on_send_distraction")
		$"Distraction Nodes"._on_send_distraction(chosenDist)
		# sendDistraction.emit(chosenDist)
	chosenDist = 0
	#print("chosenDist reset to " + str(chosenDist))


func _on_g_timer_new_time():
	timeString = $"gTimer".timeString
	$"Camera2D"._update_time(timeString)
	pass # Replace with function body.


func _on_chore_nodes_chore_complete():
	addScore = $"gTimer".currentTime
	$"Camera2D"._update_score(addScore)
	pass # Replace with function body.


func _on_g_timer_timeout():
	$"Camera2D"._end_game()


func _on_distraction_nodes_update_dist(activeDists):
	#print("updateDist signal received, running Gameplay._on_distraction_nodes_update_dist(" + str(activeDists) + ")")
	#print("calling Camera._update_alien(" + str(activeDists) + ")")
	$"Camera2D"._update_alien(activeDists)
	#Engine.time_scale = 0
	#print(str(Engine.time_scale))
	Engine.time_scale = activeDists + 1
	#print("Engine.time_scale set to " + str(Engine.time_scale))
