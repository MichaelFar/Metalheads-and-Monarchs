extends CharacterBody2D

class_name bullet

@export var speed = 2500

@export var damage = 10.0
@export var spreadRange : float = 250.0
@export var KBStrength = 0.5 #This is multiplied by the enemy's max speed to get knockback value
var yInfluence = 0.0
var xInfluence = 0.0
var influenceVector = Vector2.ZERO

func _ready():
	
	initialize()

func _physics_process(delta):
	
	move_bullet()

func _on_lifetime_timeout():
	queue_free()

			
func move_bullet():
	velocity = transform.x * speed
	velocity += influenceVector
	move_and_slide()

func area_detection(area):
	if(area.name == "Hurtbox" || area.name == "obstacle"):
		if(area.has_method("get_node_type")):
			if(area.get_node_type() == 'enemy'):
				queue_free()
			elif(area.get_node_type() == 'player'):
				return
	
		queue_free()


func initialize():
	var randObj = RandomNumberGenerator.new()
	xInfluence = randObj.randf_range(-1.0 * spreadRange, spreadRange)
	yInfluence = randObj.randf_range(-1.0 * spreadRange, spreadRange)
	influenceVector = Vector2(xInfluence, yInfluence)
