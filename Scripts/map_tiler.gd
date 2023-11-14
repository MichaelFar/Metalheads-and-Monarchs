extends Node2D

@export var TileResources : ResourcePreloader
var tileList = []
var numTiles = 9
var tileSize = Vector2.ZERO
var dimensions = Vector2(sqrt(numTiles), sqrt(numTiles))
var totalTiles = 0
var frame = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	
	tileList = TileResources.get_resource_list()
	#spawn_new_tile(global_position)
	spawn_initial_tiles()
	
func _process(delta):
	frame += 1
	if(frame % 120 == 0):
		print("Total tiles is now " + str(totalTiles))
func spawn_new_tile(g_positionOfNewTile): 
	totalTiles += 1
	var randOBJ = RandomNumberGenerator.new()
	var randIndex = randOBJ.randi_range(0, tileList.size() - 1)
	var tileInstance = TileResources.get_resource(tileList[randIndex])
	tileInstance = tileInstance.instantiate()
	Globals.currentLevel.call_deferred("add_child", tileInstance)
	
	tileInstance.mustSpawnNeighbor.connect(spawn_new_tile)
	tileInstance.derendered.connect(subtract_count)
	tileSize = tileInstance.tileSize
	tileInstance.global_position = g_positionOfNewTile
	
func spawn_initial_tiles():
	for i in range(dimensions.x - 1):
		for j in range(dimensions.y - 1):
			spawn_new_tile(Vector2(i * tileSize.x, j * tileSize.y))
func subtract_count():
	totalTiles -= 1
