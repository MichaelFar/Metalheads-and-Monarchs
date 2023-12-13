extends Node2D

@export var upgrade_coefficient = 1.05
# Called when the node enters the scene tree for the first time.
var frame = 0
func _ready():
	print("Upgrade added")
	get_parent().adjust_max_health(get_parent().max_health * upgrade_coefficient)
	

func _process(delta):
	frame += 1
	if(frame == 3):
		get_parent().heal(get_parent().max_health * (upgrade_coefficient))
		queue_free()
