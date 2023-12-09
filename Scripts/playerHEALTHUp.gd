extends Node2D

@export var upgrade_coefficient = 1.05
# Called when the node enters the scene tree for the first time.
func _ready():
	print("Upgrade added")
	get_parent().adjust_max_health(get_parent().max_health * upgrade_coefficient)
	get_parent().heal(get_parent().max_health * (upgrade_coefficient))


