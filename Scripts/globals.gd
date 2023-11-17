extends Node

var player = null#Reference to player scene
var currentLevel = null 
var spawner = null
var game_timer = null
var activeEnemies = []

func reset_game():
	var newPlayer = preload("res://Scenes/player.tscn")
	var tile = preload("res://Scenes/map_tiler.tscn")
	for i in activeEnemies:
		i.queue_free()
	activeEnemies = []
	player.queue_free()
	newPlayer = newPlayer.instantiate()
	tile = tile.instantiate()
	currentLevel.add_child(tile)
	currentLevel.add_child(newPlayer)
	player = newPlayer
	
	
func _process(delta):
	if(Input.is_action_just_released('restart')):
		reset_game()
