extends Control

@export var game_timer : Timer

@export var text_node : RichTextLabel
@export var initialMinutes = 5
var totalTimeSec = initialMinutes * 60
var maxTime = totalTimeSec

var minutes = totalTimeSec / 60
var seconds = 0
var playerDied = false

# Called when the node enters the scene tree for the first time.
func _ready():
	#position = Vector2(0.0, get_viewport().size.y)
	text_node.text = update_text()
	position.y = get_viewport_rect().size.y / -2.0
	

func _process(delta):
	if(totalTimeSec == maxTime):
		Globals.player.has_died.connect(game_over)
func _on_timer_timeout():
	if(!playerDied):
		totalTimeSec -= 1
		if ((maxTime - totalTimeSec) % 10 == 0):
			Globals.spawner.spawn_enemies()
			Globals.spawner.spawnMin += 1
			Globals.spawner.spawnMax += 1
		minutes = totalTimeSec / 60
		seconds = totalTimeSec % 60
		
		game_timer.start
		
		text_node.text = update_text()
func update_text():
	var format_string = "[center]{0} : {1}[/center]"

	var actual_string = format_string.format({"0": str(minutes), "1": str(seconds if seconds > 9 else "0" + str(seconds))})
	
	return actual_string

func game_over():
	playerDied = true
	text_node.text = "GAME OVER \n Your final time was: " + update_text()
