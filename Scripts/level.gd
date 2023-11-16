extends Node2D


@export var playerNode : CharacterBody2D
var frame = 0
var tileCount = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	Globals.player = playerNode
	Globals.currentLevel = self
	add_child(load("res://Scenes/map_tiler.tscn").instantiate())

# Called every frame. 'delta' is the elapsed time since the previous frame.

func _on_child_exiting_tree(node):
	print("Number of children is " + str(get_children().size()))
