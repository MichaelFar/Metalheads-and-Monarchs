extends Node2D
var weapons = []


var current_weapon_index = 0
var current_weapon = null
@export var bulletsList : ResourcePreloader
@export var cooldown_timer : Timer
@export var gun_offset : Marker2D

func _ready():
	
	weapons = bulletsList.get_resource_list()
	current_weapon = bulletsList.get_resource(weapons[current_weapon_index])
	
func _process(delta):
	if(get_parent().health >= 0.0):
		if Input.is_action_pressed("Shoot") and cooldown_timer.is_stopped():
			shoot()
			
		if Input.is_action_just_pressed("Switch_weapon_up"):
			var direction = 1
			switch_weapon(direction)
		
		if Input.is_action_just_pressed("Switch_weapon_down"):
			var direction = -1 
			switch_weapon(direction)
	
func switch_weapon(direction):
	current_weapon_index += direction
	if current_weapon_index > weapons.size() - 1:
		current_weapon_index = 0
	if current_weapon_index < 0:
		current_weapon_index = weapons.size() - 1
		
		
	current_weapon = bulletsList.get_resource(weapons[current_weapon_index])


func shoot():
	var p = current_weapon.instantiate()
	Globals.currentLevel.add_child(p)
	p.global_transform = gun_offset.global_transform
	cooldown_timer.wait_time = p.cooldown
	cooldown_timer.start()
