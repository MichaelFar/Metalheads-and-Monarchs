extends CharacterBody2D

var playerNode = null

@export var acceleration = 600
@export var max_speed = 200
@export var damage = 10
@export var RayCastContainer : CharacterBody2D
@export var raycast = true
@export var sprite : Sprite2D
@export var health = 100.0
@export var healthbar : ProgressBar

# Called when the node enters the scene tree for the first time.
func _ready():
	playerNode = get_parent().playerNode
	healthbar.value = health

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



func _on_hurtbox_area_entered(area):
	if(area.name == "Hitbox" && !area.owner.has_method("get_node_type")):
		print("Hit enemy")
		health -= area.get_parent().damage
		healthbar.value = health
		
		
func get_node_type():
	return "enemy"
