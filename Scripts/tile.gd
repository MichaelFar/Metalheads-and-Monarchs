extends Node2D

class_name TileSquare
@export var sprite : Sprite2D
@export var area : Area2D
@export var TileDetector : Node2D

var raycastList = []
var tileNeighbors = []
var rect : Rect2
var tileSize = Vector2.ZERO
var playerPresent = false
var frame = 0
var missing_neighbors = []
signal playerEntered
signal playerExited
signal mustSpawnNeighbor(Vector2)
# Called when the node enters the scene tree for the first time.
func _ready():
	rect = sprite.get_rect()
	area.get_children()[0].shape.size = rect.size
	tileSize = rect.size
	z_index = -5
	raycastList = TileDetector.get_children()
	

func _process(delta):
	frame += 1
	if frame >= 1 / delta:
		frame = 0
		#print("Frame rate is " + str(1 / delta))
	
func _on_area_2d_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	if(area != null):
		
		if area.get_parent() == Globals.player:
			playerEntered.emit()
			playerPresent = true
			if(!has_all_neighbors()):
				for i in missing_neighbors:
					mustSpawnNeighbor.emit(i)
		if area.name == 'Spawner':
			sprite.show()
			

func _on_area_2d_area_shape_exited(area_rid, area, area_shape_index, local_shape_index):
	if(area != null):
		
		if area.get_parent() == Globals.player:
			playerExited.emit()
			playerPresent = false
		if area.name == 'Spawner':
			sprite.hide()
			

func has_all_neighbors():
	var tile_count = 0
	missing_neighbors = []
	var space_state = get_world_2d().direct_space_state
	
	print("###############################")
	print("I am " + name)
	for i in raycastList:
		var query = PhysicsPointQueryParameters2D.new()
		query.position = i.position + global_position
		
		query.collide_with_areas = true
		query.collide_with_bodies = false
		query.collision_mask = area.collision_layer
		var result = space_state.intersect_point(query)
		
		if(result.size() == 0):
			missing_neighbors.append(i.global_position)
			print("Added missing neighbor " + i.name + " "  + str(i.global_position))
		elif(result.size() == 1):
			tile_count += 1
		
				

	print("Total count is " + str(tile_count))
	print("###############################")
	return tile_count == raycastList.size()
