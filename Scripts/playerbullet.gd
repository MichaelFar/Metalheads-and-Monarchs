extends CharacterBody2D
@export var speed = 5000

@export var damage = 10.0

var yInfluence = 0.0
var xInfluence = 0.0
var influenceVector = Vector2.ZERO
func _ready():
	var randObj = RandomNumberGenerator.new()
	xInfluence = randObj.randf_range(-1000.0, 1000.0)
	yInfluence = randObj.randf_range(-1000.0, 1000.0)
	influenceVector = Vector2(xInfluence, yInfluence)

func _physics_process(delta):
	
	velocity = transform.x * speed
	velocity += influenceVector.normalized() * yInfluence
	move_and_slide()

func _on_lifetime_timeout():
	queue_free()


func _on_hitbox_area_entered(area):
	if(area.name == "Hurtbox" || area.name == "obstacle"):
		queue_free()

