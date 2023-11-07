extends CharacterBody2D

var shotgun_bullet = null

@export var cooldown = 0.60
# Called when the node enters the scene tree for the first time.
func _ready():
	shotgun_bullet = preload("res://Projectiles/shotgun_bullet.tscn")
	
	for i in range(3):
		
		var bullet_scene = shotgun_bullet.instantiate()
		
		Globals.currentLevel.add_child(bullet_scene)
		
		bullet_scene.global_transform = Globals.player.graphics.global_transform
		
		bullet_scene.look_at(get_global_mouse_position())


