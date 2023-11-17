extends Node2D

@export var animationPlayer : AnimationPlayer
# Called when the node enters the scene tree for the first time.
func _ready():
	var randOBJ = RandomNumberGenerator.new()
	rotation_degrees = randOBJ.randf_range(-180, 180)
	animationPlayer.play("hit")

