extends Node

var choreNode = preload("res://Assets/chore.tscn")

signal choreComplete

var spawnLocations: PackedVector2Array
var isOccupied: Array
var choreMax: int = 0
var choreCount: int = 0
var locationCount: int = 0
#var newLocation: int = 0
var maxSpawnTime: int = 0
var minSpawnTime: int = 0
var baseSpawnTime: int = 0
var timerOn: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	choreMax = get_meta("maxChores")
	maxSpawnTime = get_meta("maxTime") + 1
	minSpawnTime = get_meta("minTime")
	baseSpawnTime = maxSpawnTime - minSpawnTime
	spawnLocations = PackedVector2Array([Vector2(-546, 224), Vector2(499, 147), Vector2(81, 140), Vector2(356, 235), Vector2(-171, 59), Vector2(1062, -64), Vector2(683, 159), Vector2(1256, 131), Vector2(981, 239), Vector2(1535, 222), Vector2(2162, -61), Vector2(1766, 237), Vector2(2321, 150), Vector2(2808, 237), Vector2(2062, 214), Vector2(-1377, 147), Vector2(-1676, 236), Vector2(-904, 173), Vector2(-1196, 240), Vector2(-661, 275)])
	locationCount = spawnLocations.size()
	isOccupied.resize(locationCount)
	for i in range(0,locationCount):
		isOccupied[i] = false
	while choreCount < choreMax:
		spawn()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if choreCount < choreMax && timerOn == false:
		#print("choreCount less than maximum")
		var startTime: int = randi() % baseSpawnTime + minSpawnTime
		$"cTimer".start(startTime)
		#print("cTimer started with " + str(startTime) + " seconds")
		timerOn = true
	pass


func spawn():
	#print("spawn called")
	var openConfirm: bool = false
	var newLocation: int = randi() % locationCount
	while openConfirm == false:
		if isOccupied[newLocation] == true:
			newLocation = randi() % locationCount
			openConfirm = false
			#print("position occupied, finding new")
		else:
			isOccupied[newLocation] = true
			openConfirm = true
			#print("position unoccupied")
	#print("spawn location chosen: " + str(spawnLocations[newLocation]))
	var spawnNode = choreNode.instantiate()
	#print("chore spawned")
	spawnNode.position = spawnLocations[newLocation]
	#print("chore moved to " + str(spawnNode.position))
	add_child(spawnNode)
	spawnNode.connect("choreClicked",Callable(self,"_on_chore_chore_clicked"))
	#print("signal connected")
	choreCount += 1
	#print("chore count is " + str(choreCount) + "/" + str(choreMax))


func _on_chore_chore_clicked(chorePos):
	#print(str(chorePos))
	choreComplete.emit()
	choreCount -= 1
	for i in range(0,spawnLocations.size()):
		if spawnLocations[i] == chorePos:
			isOccupied[i] = false
			#print("occupied status set to false")
	#print("chore removed")
	#print("chore count is " + str(choreCount) + "/" + str(choreMax))
	pass # Replace with function body.


func _on_c_timer_timeout():
	#print("cTimer complete, calling spawn")
	spawn()
	timerOn = false
	pass # Replace with function body.
