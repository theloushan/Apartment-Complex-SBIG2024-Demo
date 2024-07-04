extends Node

# signal sendDistraction

var distArray = get_tree().get_nodes_in_group("Distractions")
var distCount: int = 0
var chosenDist: int = 0
var groupNode: Node = null

# Called when the node enters the scene tree for the first time.
func _ready():
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
