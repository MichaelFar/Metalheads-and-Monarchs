extends Node2D


@export var sprite : Sprite2D
@export var area : Area2D
@export var TileDetector : Node2D
@export var notifier : VisibleOnScreenNotifier2D
var raycastList = []
var tileNeighbors = []
var rect : Rect2
var tileSize = Vector2.ZERO
var playerPresent = false
var frame = 0
var missing_neighbors = []
var existing_neighbors = []

signal mustSpawnNeighbor(Vector2)

# Called when the node enters the scene tree for the first time.
func _ready():
	rect = sprite.get_rect()
	area.get_children()[0].shape.size = rect.size
	tileSize = rect.size
	#notifier.rect = rect
	
	z_index = -5
	raycastList = TileDetector.get_children()
	name = "tile"
	
func _process(delta):
	frame += 1
	if frame % 2 == 0:
		pass
	
func _on_area_2d_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	if(area != null):

		if area.get_parent() == Globals.player:
			call_deferred("send_tile_info")
			playerPresent = true
			
#		if area.name == 'Spawner':
#			sprite.show()
			
		
func has_all_neighbors():
	var tile_count = 0
	missing_neighbors = []
	existing_neighbors = []
	var space_state = get_world_2d().direct_space_state
	
#	print("###############################")
#	print("I am " + name)
	for i in raycastList:
		var query = PhysicsPointQueryParameters2D.new()
		query.position = i.position + global_position
		
		query.collide_with_areas = true
		query.collide_with_bodies = true
		query.collision_mask = area.collision_layer
		
		var result = space_state.intersect_point(query)
		
		if result.size() > 1:
			for j in range(result.size() - 1):
				if(!result[j].collider.get_parent().playerPresent):
					result[j].collider.get_parent().queue_free()
		if(result.size() == 0):
			missing_neighbors.append(i.global_position)
			#print("I am " + name + ": Added missing neighbor " + i.name + " "  + str(i.global_position))
		else:
			existing_neighbors.append(result[0].collider.get_parent())
		
#	print("Total count is " + str(tile_count))
#	print("###############################")
	return missing_neighbors.size() == 0

func send_tile_info():
	
	playerPresent = true
	if(!has_all_neighbors()):
		#print("Missing neighbors size is " + str(missing_neighbors.size()))
		for i in missing_neighbors:
			
			mustSpawnNeighbor.emit(i)
		missing_neighbors = []
		
func _on_tile_area_area_shape_exited(area_rid, area, area_shape_index, local_shape_index):
	if(area != null):
		
		if(area.name == 'Spawner'):
			print("Deleting self " + str(name))
			queue_free()
