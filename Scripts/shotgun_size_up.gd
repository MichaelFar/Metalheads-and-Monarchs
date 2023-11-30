extends Node2D

@export var upgrade_coefficient = 1.10
# Called when the node enters the scene tree for the first time.
func _ready():
	print("Upgrade added")
	get_parent().set_stats(Globals.Stats.AREA, get_parent().scale * Vector2(upgrade_coefficient, upgrade_coefficient))


