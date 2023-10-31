extends CharacterBody2D
@export var speed = 5000

@export var damage = 10.0

var yInfluence = 0.0
func _ready():
	var randObj = RandomNumberGenerator.new()
	yInfluence = randObj.randf_range(-1000.0, 1000.0)


func _physics_process(delta):
	
	velocity = transform.x * speed
	velocity.y += yInfluence
	velocity.x += yInfluence
	move_and_slide()

func _on_lifetime_timeout():
	queue_free()


func _on_hitbox_area_entered(area):
	if(area.name == "Hurtbox" || area.name == "obstacle"):
		queue_free()

