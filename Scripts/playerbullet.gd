extends CharacterBody2D
@export var speed = 2500

@export var damage = 10.0

var yInfluence = 0.0
var xInfluence = 0.0
var influenceVector = Vector2.ZERO
@export var spreadRange : float = 500.0
func _ready():
	look_at(transform.x)
	var randObj = RandomNumberGenerator.new()
	xInfluence = randObj.randf_range(-1.0 * spreadRange, spreadRange)
	yInfluence = randObj.randf_range(-1.0 * spreadRange, spreadRange)
	influenceVector = Vector2(xInfluence, yInfluence)

func _physics_process(delta):
	
	velocity = transform.x * speed
	velocity += influenceVector.normalized() * yInfluence
	move_and_slide()

func _on_lifetime_timeout():
	queue_free()


func _on_hitbox_area_entered(area):
	if(area.name == "Hurtbox" || area.name == "obstacle"):
		if(area.has_method("get_node_type")):
			if(area.get_node_type() == 'enemy'):
				queue_free()
			elif(area.get_node_type() == 'player'):
				return
	
		queue_free()
			

