extends Sprite2D


func ready():
	get_viewport().size_changed.connect(reposition)
	
	
	
func reposition():
	global_position = Vector2.ZERO
