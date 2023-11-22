extends CharacterBody2D

var power_up_active = false

@export var move_speed = 300

@export var healthbar : Control
@export var health = 100
@export var max_health = 100
@export var graphics : Node2D
@export var player_weapon_changer : Node2D
@export var melee : CharacterBody2D

var move_dir = Vector2.ZERO

signal has_died

func _ready():
	healthbar.healthbar.value = health
	Globals.player = self

func _physics_process(delta):
	if(health >= 0.0):
		move_dir = Input.get_vector("Left", "Right", "Up", "Down")
		graphics.look_at(get_global_mouse_position())
		velocity = move_dir * move_speed
		
		move_and_slide()
	else:
		has_died.emit()
	
	graphics.visible = !melee.visible

func _on_hurtbox_area_entered(area):
	
	if area.name == "Hitbox":
		
		healthbar.healthbar.value -= area.get_parent().damage
		health -= area.get_parent().damage
		health = clampf(health, 0.0, max_health)

func get_node_type():
	return "player"

func _on_powerup_area_entered(area):
	##Reparent powerup here
	power_up_active = true
func _on_timer_timeout():
	power_up_active = false
