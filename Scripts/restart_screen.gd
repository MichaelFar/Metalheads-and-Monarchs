extends VBoxContainer


# Called when the node enters the scene tree for the first time.
	
func _on_restart_button_button_up():
	Globals.reset_game()

func _on_main_menu_button_button_up():
	get_tree().change_scene_to_file("res://Scenes/title_screen.tscn")
	

