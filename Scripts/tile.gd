extends Node2D

@export var sprite : Sprite2D
@export var area : Area2D

var rect : Rect2
var tileSize = Vector2.ZERO
var playerPresent = false

signal playerEntered
signal playerExited
# Called when the node enters the scene tree for the first time.
func _ready():
	rect = sprite.get_rect()
	area.get_children()[0].shape.size = rect.size
	tileSize = rect.size
	

func _on_area_2d_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	if(area != null):
		
		if area.get_parent() == Globals.player:
			playerEntered.emit()
			playerPresent = true


func _on_area_2d_area_shape_exited(area_rid, area, area_shape_index, local_shape_index):
	if(area != null):
		
		if area.get_parent() == Globals.player:
			playerExited.emit()
			playerPresent = false

func print_hello():
	print("Hello from animation")
