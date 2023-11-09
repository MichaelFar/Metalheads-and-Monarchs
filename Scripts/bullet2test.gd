extends bullet

func area_entered(area):
	if(area.name == "Hurtbox" || area.name == "obstacle"):
		if(area.has_method("get_node_type")):
			if(area.get_node_type() == 'enemy'):
				queue_free()
			elif(area.get_node_type() == 'player'):
				return
	
		queue_free()
