extends CharacterBody2D

@export var speed = 2500

@export var damage = 10.0
@export var spreadRange : float = 250
@export var KBStrength = 0.5 #This is multiplied by the enemy's max speed to get knockback value
@export var cooldown = 0.3
@export var has_KB = true
var hit_effect = null
var yInfluence = 0.0
var xInfluence = 0.0
var influenceVector = Vector2.ZERO

func _ready():
	hit_effect = preload("res://Scenes/hit_effect.tscn")
	look_at(transform.x)
	var randObj = RandomNumberGenerator.new()
	xInfluence = randObj.randf_range(-1.0 * spreadRange, spreadRange)
	yInfluence = randObj.randf_range(-1.0 * spreadRange, spreadRange)
	influenceVector = Vector2(xInfluence, yInfluence)

func _physics_process(delta):
	
	velocity = transform.x * speed
	velocity += influenceVector
	move_and_slide()

func _on_lifetime_timeout():
	queue_free()


func _on_hitbox_area_entered(area):
	if(area.name == "Hurtbox" || area.name == "obstacle"):
		hit_effect = hit_effect.instantiate()
		Globals.currentLevel.add_child(hit_effect)
		hit_effect.global_position = global_position
		if(area.has_method("get_node_type")):
			if(area.get_node_type() == 'enemy'):
				
				queue_free()
			elif(area.get_node_type() == 'player'):
				return
		hit_effect = preload("res://Scenes/hit_effect.tscn")
		queue_free()
			


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
