extends Node

var player = null#Reference to player scene
var currentLevel = null #Current level
var spawner = null#Spawner attached to the player
var game_timer = null#screen_text scene
var activeEnemies = []#Number of enemies that are active
var weapon_changer = null#scene responsible for changing weapons
var melee = null#reference to the player melee scene
var music_player = null
var current_level


enum Stats {DAMAGE, SPREADRANGE, KBSTRENGTH, COOLDOWN, KBENABLED, AREA}



func reset_game():
	
	var newPlayer = preload("res://Scenes/player.tscn")
	var tile = preload("res://Scenes/map_tiler.tscn")
	
	for i in currentLevel.get_children():
		i.queue_free()
	activeEnemies = []
	
	newPlayer = newPlayer.instantiate()
	tile = tile.instantiate()
	currentLevel.add_child(tile)
	currentLevel.add_child(newPlayer)
	player = newPlayer
	
	
func _process(delta):
	if(Input.is_action_just_released('restart')):
		reset_game()
	if(Input.is_action_just_released('upgrade_test')):
		game_timer.upgrade_begin()
