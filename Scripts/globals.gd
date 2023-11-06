extends Node

var player = null#Reference to player scene
var currentLevel = null
var spawner = null
var game_timer = null
var activeEnemies = []

func reset_game():
	
	var newPlayer = preload("res://Scenes/player.tscn")
	for i in activeEnemies:
		i.queue_free()
	activeEnemies = []
	player.queue_free()
	newPlayer = newPlayer.instantiate()
	currentLevel.add_child(newPlayer)
	player = newPlayer
	
	
func _process(delta):
	if(Input.is_action_just_released('restart')):
		reset_game()
