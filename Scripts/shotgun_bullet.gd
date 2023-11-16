extends bullet


func area_entered(area):
	if(area.name == "Hurtbox" || area.name == "obstacle"):
		if(area.has_method("get_node_type")):
			if(area.get_node_type() == 'enemy'):
				queue_free()
			elif(area.get_node_type() == 'player'):
				return
	
		queue_free()
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
