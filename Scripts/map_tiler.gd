extends Node2D

@export var TileResources : ResourcePreloader
var tileList = []
var numTiles = 9
var tileSize = Vector2.ZERO
var dimensions = Vector2(sqrt(numTiles), sqrt(numTiles))
# Called when the node enters the scene tree for the first time.
func _ready():
	tileList = TileResources.get_resource_list()
	spawn_new_tile(global_position)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

#func populate_tiles():
#	var randOBJ = RandomNumberGenerator.new()
#
#	for i in range(dimensions.x):
#		for j in range(dimensions.y):
#
#			spawn_new_tile(Vector2(tileSize.x * (i), tileSize.y * (j)))
			

func spawn_new_tile(g_positionOfNewTile): 
	var randOBJ = RandomNumberGenerator.new()
	var randIndex = randOBJ.randi_range(0, tileList.size() - 1)
	var tileInstance = TileResources.get_resource(tileList[randIndex])
	tileInstance = tileInstance.instantiate()
	Globals.currentLevel.call_deferred("add_child", tileInstance)
	
	tileInstance.mustSpawnNeighbor.connect(spawn_new_tile)
	tileSize = tileInstance.tileSize
	tileInstance.global_position = g_positionOfNewTile
	
