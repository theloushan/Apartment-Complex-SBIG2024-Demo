extends Camera2D

var scoreValue: int = 0
var keepUpdated: bool = true

# Called when the node enters the scene tree for the first time.
func _ready():
	$"Alien Sprite".play("alienIdle")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_left_button_pressed():
	if position.x == 0:
		position.x = -1155 # Move to BG4
	elif position.x == 1155:
		position.x = 0 # Move to BG1
	elif position.x == 2310:
		position.x = 1155 # Move to BG2
	elif position.x == -1155:
		position.x = 2310 # Move to BG3


func _on_right_button_pressed():
	if position.x == 0:
		position.x = 1155 # Move to BG2
	elif position.x == 1155:
		position.x = 2310 # Move to BG3
	elif position.x == 2310:
		position.x = -1155 # Move to BG4
	elif position.x == -1155:
		position.x = 0 # Move to BG1


func _update_time(newTime):
	if keepUpdated == true:
		$"Time".text = "Time: " + newTime


func _update_score(newScore):
	if keepUpdated == true:
		scoreValue = scoreValue + newScore
		$"Score".text = "Score: " + str(scoreValue)


func _end_game():
	$"End Alien".visible = true
	$"End Alien".play()
	$"End Alien/End Screen/Score Total".text = str(scoreValue)
	$"End Alien/End Screen/End Buttons/Exit Button".disabled = false
	$"End Alien/End Screen/End Buttons/Menu Button".disabled = false
	$"Left Button".disabled = true
	$"Right Button".disabled = true
	_update_time("0:00")
	keepUpdated = false
