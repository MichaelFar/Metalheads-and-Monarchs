extends Node2D
func _exit_tree():
	var randi = RandomNumberGenerator.new()
	var random = randi.randi_range(1, 100)
	
	if (random <= 15):
		pass
