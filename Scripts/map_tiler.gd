extends Node2D

@export var TileResources : ResourcePreloader
var tileList = []
var numTiles = 9
var tileSize = Vector2.ZERO
var dimensions = Vector2(sqrt(numTiles), sqrt(numTiles))
# Called when the node enters the scene tree for the first time.
func _ready():
	tileList = TileResources.get_resource_list()
	populate_tiles()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func populate_tiles():
	var randOBJ = RandomNumberGenerator.new()

	for i in range(dimensions.x):
		for j in range(dimensions.y):
			var randIndex = randOBJ.randi_range(0, tileList.size() - 1)
			var tileInstance = TileResources.get_resource(tileList[randIndex])
			tileInstance = tileInstance.instantiate()
			Globals.currentLevel.add_child(tileInstance)
			tileSize = tileInstance.tileSize
			tileInstance.global_position.x = tileSize.x * (i)
			tileInstance.global_position.y = tileSize.y * (j)
			print("Tile position is " + str(tileInstance.global_position) + " and i is " + str(i))
