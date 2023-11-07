extends Area2D

@export var speed = 5000


func _physics_process(delta):
	position += transform.x * speed * delta


func _on_lifetime_timeout():
	queue_free()
