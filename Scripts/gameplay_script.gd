extends Node

# signal sendDistraction

var distArray: Array # = get_tree().get_nodes_in_group("Distractions")
var distCount: int = 0
var chosenDist: int = 0
var groupNode: Node = null
var timeString: String

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
	$"Distraction Nodes"._on_send_distraction(chosenDist)
	# sendDistraction.emit(chosenDist)
	chosenDist = 0


func _on_g_timer_new_time():
	timeString = $"gTimer".timeString
	$"Camera2D"._update_time(timeString)
	pass # Replace with function body.
