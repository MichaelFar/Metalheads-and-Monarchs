extends CharacterBody2D
@export var speed = 5000

@export var damage = 10.0


func _physics_process(delta):
	
	velocity = transform.x * speed
	move_and_slide()

func get_node_type():
	return "projectile"

func _on_hitbox_area_entered(area):
	if(area.name == "Hurtbox" || area.name == "obstacle"):
		print("Hit something as " + name)
		queue_free()


func _on_lifetime_timeout():
	queue_free()
