extends CharacterBody2D

var playerNode = null

@export var acceleration = 600
@export var max_speed = 200
@export var damage = 10
@export var RayCastContainer : CharacterBody2D
@export var raycast = true
@export var sprite : Sprite2D
# Called when the node enters the scene tree for the first time.
func _ready():
	playerNode = get_parent().playerNode


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var destination = playerNode.global_position - global_position 
	
	destination = destination.normalized()
	if(raycast):
		RayCastContainer.supplied_direction = destination
		#print("Supplied direction is " + str(destination))
		destination = RayCastContainer.suggestedVector
	#print("Resulting direction is " + str(destination))
	sprite.look_at(playerNode.global_position)
	velocity = velocity.move_toward(destination * max_speed, delta * acceleration)
	move_and_slide()
