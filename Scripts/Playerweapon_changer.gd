extends Node2D
var weapons = []


var current_weapon_index = 0
var current_weapon = null
signal shooting(float)
signal switched_weapon(int)
@export var bulletsList : ResourcePreloader
@export var cooldown_timer : Timer
@export var gun_offset : Marker2D
@export var pistolModifiers : ResourcePreloader
@export var smgModifiers : ResourcePreloader
@export var shotgunModifiers : ResourcePreloader
func _ready():
	Globals.weapon_changer = self
	weapons = bulletsList.get_resource_list()
	current_weapon = bulletsList.get_resource(weapons[current_weapon_index])
	switch_weapon(0)
	
func _process(delta):
	if(get_parent().health >= 0.0):
		if Input.is_action_pressed("Shoot") and cooldown_timer.is_stopped() && get_parent().graphics.visible:
			shoot()
			
		if Input.is_action_just_pressed("Switch_weapon_up"):
			var direction = 1
			switch_weapon(direction)
		
		if Input.is_action_just_pressed("Switch_weapon_down"):
			var direction = -1 
			switch_weapon(direction)
	
func switch_weapon(direction):
	var offset_vector = Vector2.ZERO
	current_weapon_index += direction
	if current_weapon_index > weapons.size() - 1:
		current_weapon_index = 0
	if current_weapon_index < 0:
		current_weapon_index = weapons.size() - 1
	
	
	current_weapon = bulletsList.get_resource(weapons[current_weapon_index])
	
	if(weapons[current_weapon_index] == 'bullet'):
		print("Offset changed")
		offset_vector = Vector2(0.0, 10.0)
	else:
		offset_vector = Vector2(0.0, -2.0)
	gun_offset.position = offset_vector
	switched_weapon.emit(current_weapon_index,offset_vector)

func shoot():
	
	var modList = load_modifiers()
	var p = current_weapon.instantiate()
	Globals.currentLevel.add_child(p)
	p.global_transform = gun_offset.global_transform
	for i in modList:
		var loadMod = get_children()[current_weapon_index].get_resource(i).instantiate()
		p.add_child(loadMod)
	cooldown_timer.wait_time = p.cooldown
	shooting.emit(p.cooldown)
	cooldown_timer.start()
	
func load_modifiers():
	var modList = get_children()[current_weapon_index].get_resource_list()
	return modList
func add_modifier_to_list(upgradeScene, loadedUpgradeScene):
	if('pistol' in upgradeScene):
		pistolModifiers.add_resource(upgradeScene, loadedUpgradeScene)
	if('smg' in upgradeScene):
		smgModifiers.add_resource(upgradeScene, loadedUpgradeScene)
	if('shotgun' in upgradeScene):
		shotgunModifiers.add_resource(upgradeScene, loadedUpgradeScene)
