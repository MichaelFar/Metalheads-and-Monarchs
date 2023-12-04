extends Node2D

@export var playerNode : CharacterBody2D
@export var musicPlayer : AudioStreamPlayer
var frame = 0
var tileCount = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	Globals.player = playerNode
	Globals.currentLevel = self
	add_child(load("res://Scenes/map_tiler.tscn").instantiate())
	musicPlayer.playing = true
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(Input.is_action_just_released("mute")):
		musicPlayer.playing = !musicPlayer.playing

func _on_child_exiting_tree(node):
	print("Number of children is " + str(get_children().size()))
