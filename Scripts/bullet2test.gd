extends CharacterBody2D

func _ready():
	hit_effect = preload("res://Scenes/hit_effect.tscn")
	look_at(transform.x)
	var randObj = RandomNumberGenerator.new()
	xInfluence = randObj.randf_range(-1.0 * spreadRange, spreadRange)
	yInfluence = randObj.randf_range(-1.0 * spreadRange, spreadRange)
	influenceVector = Vector2(xInfluence, yInfluence)

func area_entered(area):
	if(area.name == "Hurtbox" || area.name == "obstacle"):
		hit_effect = hit_effect.instantiate()
		Globals.currentLevel.add_child(hit_effect)
		hit_effect.global_position = global_position
		if(area.has_method("get_node_type")):
			if(area.get_node_type() == 'enemy'):
				
				queue_free()
			elif(area.get_node_type() == 'player'):
				return
	
		queue_free()
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
