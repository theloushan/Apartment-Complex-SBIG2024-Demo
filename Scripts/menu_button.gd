extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_start_button_pressed():
	$"Start Button/Start SFX".play()
	get_tree().change_scene_to_file("res://Levels/level 1.tscn")


func _on_menu_button_pressed():
	$"Menu Button/Menu SFX".play()
	get_tree().change_scene_to_file("res://Levels/main menu.tscn")


func _on_exit_button_pressed():
	$"Exit Button/Exit SFX".play()
	get_tree().quit()
