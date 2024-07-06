extends Button

signal choreClicked

var choreNum: int = 0
# var currentPos: Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	choreNum = randi() % 8
	$"Chore Sprite".frame = choreNum
	$"Chore Sound".play()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _pressed():
	emit_signal("choreClicked",global_position)
	self.queue_free()
