extends CharacterBody2D

@export var damage = 10.0
@export var KBStrength = 0.5 #This is multiplied by the enemy's max speed to get knockback value
@export var cooldown = 0.3
@export var has_KB = true
@export var animationplayer : AnimationPlayer

func _physics_process(delta):
	if(get_parent().health >= 0.0):
		if Input.is_action_just_pressed("Melee"):
			animationplayer.play("Melee")
	look_at(get_global_mouse_position())
	
