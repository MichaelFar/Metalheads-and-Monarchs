extends Control

@export var game_timer : Timer

@export var text_node : RichTextLabel
@export var initialMinutes = 5
@export var upgradePanel : Panel
@export var upgradeLabel : Label
@export var upgradeOptions : ResourcePreloader

var upgradePositions = []

var totalEnemiesDefeated = 0
var totalTimeSec = initialMinutes * 60
var maxTime = totalTimeSec

var metal_head_count = 1

var minutes = totalTimeSec / 60
var seconds = 0
var playerDied = false
var endGame = false
var frame = 0
var showControls = true
var upgrade_target = 800

signal game_complete

func _ready():
	Globals.game_timer = self
	text_node.text = update_text()
	update_placement()
	get_viewport().size_changed.connect(update_placement)
	
	upgradePanel.hide()
	
func _process(delta):
	
	frame += 1
	
	if(frame == 1):
		Globals.player.has_died.connect(game_over)
		
	if (Input.is_action_just_released("togglecontrols")):
		showControls = !showControls
		
	if frame % 2 == 0 && !endGame:
		text_node.text = update_text()
		
func _on_timer_timeout():
	if(!playerDied && !endGame):
		totalTimeSec -= 1
		var timeScore = time_score()
		var enemyScore = enemy_score()
		if(totalTimeSec == 0):
			game_complete.emit()
			endGame = true
			game_over()
			return
		if ((maxTime - totalTimeSec) % 10 == 0):# Every 10 seconds
			
			Globals.spawner.spawn_enemies()
			Globals.spawner.spawnMin += 1
			Globals.spawner.spawnMax += 1
		if ((maxTime - totalTimeSec) % 60 == 0):
			for i in range(metal_head_count):
				
				Globals.spawner.spawn_metal_head()
			metal_head_count += 1
		if ((enemyScore + timeScore) % upgrade_target == 0 && enemyScore + timeScore != 0):
			upgrade_target += 1000
			upgrade_begin()
			
		minutes = totalTimeSec / 60
		seconds = totalTimeSec % 60
		
		game_timer.start()
		
func update_text():
	
	var format_string = "[center]{0} : {1}[/center]" + "\n" + "[center]Your score is " + str(enemy_score()) + "[/center]" + "\n" + "[center]Time bonus is " + str(time_score()) + "[/center]"
	
	var actual_string = format_string.format({"0": str(minutes), "1": str(seconds if seconds > 9 else "0" + str(seconds))})
	if(showControls):
		actual_string += "\n" + "Controls:" + "\n" + "WASD - Move" + "\n" + "Mouse - Aim" + "\n" + "LMB - Shoot" + "\n" + "RMB - melee" + "\n" + "Scroll Wheel - Switch Weapon" + "\n" + "SHOW/HIDE CONTROLS WITH H Key"
	return actual_string

func enemy_score():
	
	
	return totalEnemiesDefeated * 100
	
func time_score():
	
	return ((maxTime - totalTimeSec) / 10) * 100

func game_over():
	
	playerDied = !endGame
	endGame = true
	var totalScoreString = "\n" + "[center]Total Score is " + str((((maxTime - totalTimeSec) / 10) * 100) + totalEnemiesDefeated * 100) + "[/center]"
	text_node.text = "GAME OVER \n Your final time was: " + update_text() + totalScoreString
	
	$"Game Over".play()
	
	if(!playerDied):
		
		text_node.text = "GAME COMPLETE!!! \n Total Enemies Defeated: " + str(totalEnemiesDefeated) + totalScoreString
	
	else:
		
		for i in range(3):
			
			Globals.spawner.spawn_enemies()
			
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
	
	get_tree().paused = !get_tree().paused
	upgradePanel.show() 
	$Upgrade.play()
	var upgrade_list = populate_options()
	
	for i in range(3):
		
		var upgrade_option = upgrade_list[i]
		var upgrade_option_scene = upgradeOptions.get_resource(upgrade_option).instantiate()
		upgradePanel.add_child(upgrade_option_scene)
		upgrade_option_scene.chosen_upgrade.connect(upgrade_chosen)
		
	set_panel_height()
	
func upgrade_chosen(upgradeScene, loadedUpgradeScene):
	
	upgrade_end()
	Globals.weapon_changer.add_modifier_to_list(upgradeScene,loadedUpgradeScene)

func populate_options():
	
	var randObj = RandomNumberGenerator.new()
	
	var replacementUpgradeList = upgradeOptions.get_resource_list()
	
	var returnList = []
	
	for i in range(3):
	
		var randIndex = randObj.randi_range(0, replacementUpgradeList.size() - 1)
		returnList.append(replacementUpgradeList[randIndex])
		
		replacementUpgradeList.remove_at(randIndex)
		
	return returnList

func upgrade_end():
	get_tree().paused = !get_tree().paused
	upgradePanel.hide()
	for i in upgradePanel.get_children():
		if 'Options' in i.name:
			i.queue_free()
