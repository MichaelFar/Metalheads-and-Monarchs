extends Node2D

@export var upgrade_coefficient = 1.05
# Called when the node enters the scene tree for the first time.
func _ready():
	print("Upgrade added")
	get_parent().set_stats(Globals.Stats.DAMAGE, get_parent().damage * upgrade_coefficient)


