extends Timer

signal newTime

var startTime: int = 0 # The time that the timer should start counting from
var currentTime: int = 0
var minuteTime: int = 0
var secondTime: int = 0
var timeString: String

# Called when the node enters the scene tree for the first time.
func _ready():
	startTime = get_meta("maxTime")
	#print("startTime:" + str(startTime))
	currentTime = startTime
	#print("currentTime:" + str(currentTime))
	secondTime = startTime
	#print("secondTime:" + str(secondTime))
	while secondTime >= 60:
		secondTime -= 60
		minuteTime += 1
	#print("Processed secondTime:" + str(secondTime))
	#print("Processed minuteTime:" + str(minuteTime))
	if secondTime == 0:
		timeString = str(minuteTime) + ":00"
	elif secondTime < 10:
		timeString = str(minuteTime) + ":0" + str(secondTime)
	else:
		timeString = str(minuteTime) + ":" + str(secondTime)
	#print("timeString:" + timeString)
	newTime.emit()
	start(startTime)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print("time_left:" + str(time_left))
	#print("time_left rounded:" + str(ceili(time_left)))
	if time_left == 0:
		pass
	else:
		if currentTime != ceili(time_left):
			currentTime = ceili(time_left)
			#print("currentTime:" + str(currentTime))
			#print("secondTime:" + str(secondTime))
			#print("minuteTime:" + str(minuteTime))
			if secondTime == 0 && minuteTime > 0:
				secondTime = 59
				minuteTime -= 1
			else:
				secondTime -= 1
			#print("secondTime processed as:" + str(secondTime))
			#print("minuteTime processed as:" + str(minuteTime))
			if secondTime == 0:
				timeString = str(minuteTime) + ":00"
			elif secondTime < 10:
				timeString = str(minuteTime) + ":0" + str(secondTime)
			else:
				timeString = str(minuteTime) + ":" + str(secondTime)
			newTime.emit()
