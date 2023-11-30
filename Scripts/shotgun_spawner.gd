extends CharacterBody2D

var shotgun_bullet = null
var is_vampire = false
var frame = 0

@export var speed = 2500

@export var damage = 10.0
@export var spreadRange : float = 250
@export var KBStrength = 0.5 #This is multiplied by the enemy's max speed to get knockback value
@export var cooldown = 0.60
@export var has_KB = true
@export var powerupList : Node2D
# Called when the node enters the scene tree for the first time.
func _ready():
	
	shotgun_bullet = preload("res://Projectiles/shotgun_bullet.tscn")
	

func _process(delta):
	frame += 1
	if (frame == 1):
		for i in range(3):
		
			var bullet_scene = shotgun_bullet.instantiate()
			
			Globals.currentLevel.add_child(bullet_scene)
			bullet_scene.is_vampire = is_vampire
			bullet_scene.speed = 2500

			bullet_scene.damage = damage
			bullet_scene.spreadRange = spreadRange
			bullet_scene.KBStrength = KBStrength #This is multiplied by the enemy's max speed to get knockback value
			bullet_scene.cooldown = cooldown
			bullet_scene.has_KB = has_KB
			bullet_scene.scale = scale
			print("Scale of shotgun bullet is " + str(scale))
			
			bullet_scene.global_position = Globals.player.graphics.global_position
			bullet_scene.global_transform = Globals.player.player_weapon_changer.gun_offset.global_transform
			
			print("Shotgun vampire is " +str(is_vampire))
			#bullet_scene.look_at(get_global_mouse_position())
	else:
		queue_free()
func set_stats(stat, value):
	match stat:
		
		Globals.Stats.DAMAGE:
			damage = value
		Globals.Stats.SPREADRANGE:
			spreadRange = value
		Globals.Stats.KBSTRENGTH:
			KBStrength = value
		Globals.Stats.COOLDOWN:
			cooldown = value
		Globals.Stats.KBENABLED:
			has_KB = true#If this is true KBStrength should also be given a value
		Globals.Stats.AREA:
			scale = value
