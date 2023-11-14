extends Node2D

@export var sprite : Sprite2D
@export var animationPlayer : AnimationPlayer
@export var player : CharacterBody2D
var magnitude = 100.0
# Called when the node enters the scene tree for the first time.

func _physics_process(delta):
	var move_dir = get_parent().move_dir
	move_dir = move_dir.normalized()
	#move_dir *= magnitude
	
	if(move_dir):
		animationPlayer.play("walk")
		look_at(move_dir + global_position)
	else:
		animationPlayer.stop()
