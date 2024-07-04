extends Timer

var timerCount: int = 0 # How many times the timer has finished
var startTime: int = 0 # The time that the timer should start counting from

# Called when the node enters the scene tree for the first time.
func _ready():
	startTime = get_meta("Start_Time")
	start(startTime)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if time_left == 0:
		start(startTime - timerCount)
		timerCount += 1
	else:
		pass
