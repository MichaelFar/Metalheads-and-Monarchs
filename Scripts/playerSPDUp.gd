extends Node2D

@export var upgrade_coefficient = 1.10
# Called when the node enters the scene tree for the first time.
func _ready():
	print("Upgrade added")
	get_parent().move_speed *= upgrade_coefficient


