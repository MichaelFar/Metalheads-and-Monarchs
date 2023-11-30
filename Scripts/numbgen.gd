extends Node2D

@export var powerUPResources : ResourcePreloader
var powerUpList = []

func _ready():
	powerUpList = powerUPResources.get_resource_list()

func _exit_tree():
	var randOBJ = RandomNumberGenerator.new()
	var random = randOBJ.randi_range(1, 100)
	var randIndex = randOBJ.randi_range(0, powerUPResources.get_resource_list().size() - 1)
	if (random <= 1):
		var powerUpScene = powerUPResources.get_resource(powerUpList[randIndex]).instantiate()
		Globals.currentLevel.add_child.call_deferred(powerUpScene)
		powerUpScene.global_position = get_parent().global_position
