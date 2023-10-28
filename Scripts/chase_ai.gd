extends CharacterBody2D

var playerNode = null

@export var acceleration = 600
@export var max_speed = 200
@export var damage = 10
# Called when the node enters the scene tree for the first time.
func _ready():
	playerNode = get_parent().playerNode


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var destination = playerNode.global_position - global_position 
	destination = destination.normalized()
	look_at(playerNode.global_position)
	velocity = velocity.move_toward(destination * max_speed, delta * acceleration)
	move_and_slide()
