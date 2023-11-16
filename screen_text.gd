extends Control

@export var game_timer : Timer

@export var text_node : RichTextLabel
@export var initialMinutes = 3

var totalEnemiesDefeated = 0
var totalTimeSec = initialMinutes * 60
var maxTime = totalTimeSec
var enemy_score = 0
var time_score = 0
var minutes = totalTimeSec / 60
var seconds = 0
var playerDied = false
var endGame = false
var frame = 0
var showControls = true
signal game_complete

# Called when the node enters the scene tree for the first time.
func _ready():
	#position = Vector2(0.0, get_viewport().size.y)
	Globals.game_timer = self
	text_node.text = update_text()
	position.y = get_viewport_rect().size.y / -2.0
	get_viewport().size_changed.connect(update_placement)
	

func _process(delta):
	frame += 1
	if(frame == 1):
		Globals.player.has_died.connect(game_over)
	if (Input.is_action_just_released("togglecontrols")):
		showControls = !showControls
		
func _on_timer_timeout():
	if(!playerDied && !endGame):
		totalTimeSec -= 1
		if(totalTimeSec == 0):
			game_complete.emit()
			endGame = true
			game_over()
			return
		if ((maxTime - totalTimeSec) % 10 == 0):# Every 10 seconds
			Globals.spawner.spawn_enemies()
			Globals.spawner.spawnMin += 1
			Globals.spawner.spawnMax += 1
			#Globals.spawner.healthMod += 10.0
		minutes = totalTimeSec / 60
		seconds = totalTimeSec % 60
		
		game_timer.start
		
		text_node.text = update_text()
		
func update_text():
	
	var format_string = "[center]{0} : {1}[/center]" + "\n" + "[center]Your score is " + str(totalEnemiesDefeated * 100) + "[/center]" + "\n" + "[center]Time bonus is " + str(((maxTime - totalTimeSec) / 10) * 100) + "[/center]"
	
	var actual_string = format_string.format({"0": str(minutes), "1": str(seconds if seconds > 9 else "0" + str(seconds))})
	if(showControls):
		actual_string += "\n" + "Controls:" + "\n" + "WASD - Move" + "\n" + "Mouse - Aim" + "\n" + "LMB - Shoot" + "\n" + "RMB - melee" + "\n" + "Scroll Wheel - Switch Weapon" + "\n" + "SHOW/HIDE CONTROLS WITH H Key"
	return actual_string

func game_over():
	playerDied = !endGame
	var totalScoreString = "\n" + "[center]Total Score is " + str((((maxTime - totalTimeSec) / 10) * 100) + totalEnemiesDefeated * 100) + "[/center]"
	text_node.text = "GAME OVER \n Your final time was: " + update_text() + totalScoreString
	
	if(!playerDied):
		text_node.text = "GAME COMPLETE!!! \n Total Enemies Defeated: " + str(totalEnemiesDefeated)
	
func update_placement():
	position.y = get_viewport_rect().size.y / -2.0
