extends Control

@export var game_timer : Timer

@export var text_node : RichTextLabel
@export var initialMinutes = 3
@export var upgradePanel : Panel
@export var upgradeLabel : Label

var upgradePositions = []

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
	Globals.game_timer = self
	text_node.text = update_text()
	update_placement()
	get_viewport().size_changed.connect(update_placement)
	#upgrade_begin()
	upgradePanel.hide()
	
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
	upgradePanel.position.y = text_node.size.y / 2.0
	upgradePanel.size.x = get_viewport_rect().size.x / 3.0
	upgradePanel.position.x = upgradePanel.size.x / -2.0
	upgradeLabel.size.x = upgradePanel.size.x
	set_panel_height()
	
func set_panel_height():
	
	upgradePositions = []
	var height_needed = 0.0
	
	for i in upgradePanel.get_children():
		
		if(i != upgradePanel.get_children()[0]):
			
			height_needed = height_needed + 1.5 * i.size.y
			i.position = Vector2(0, height_needed - (i.size.y ))
			upgradePositions.append(height_needed)
			
	upgradePanel.size.y = height_needed

func upgrade_begin():
	
	if upgradePanel.visible:
		
		upgradePanel.hide()
		for i in upgradePanel.get_children():
			if 'Options' in i.name:
				i.queue_free()
	else:
		
		upgradePanel.show()
		var upgrade_option = preload("res://Scenes/upgrade_options.tscn")
		for i in range(3):
			var upgrade_option_scene = upgrade_option.instantiate()
			upgradePanel.add_child(upgrade_option_scene)
			upgrade_option_scene.chosen_upgrade.connect(upgrade_chosen)
		set_panel_height()
	

func upgrade_chosen(upgradeScene, loadedUpgradeScene):
	
	upgrade_begin()
	Globals.weapon_changer.add_modifier_to_list(upgradeScene,loadedUpgradeScene)
