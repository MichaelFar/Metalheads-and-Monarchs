extends CharacterBody2D


@export var move_speed = 300

@export var healthbar : Control
@export var health = 100
@export var graphics : Node2D
@export var player_weapon_changer : Node2D
signal has_died

func _ready():
	healthbar.healthbar.value = health
	Globals.player = self

func _physics_process(delta):
	if(health >= 0.0):
		var move_dir = Input.get_vector("Left", "Right", "Up", "Down")
		graphics.global_rotation = global_position.direction_to(get_global_mouse_position()).angle() + PI/2.0
		velocity = move_dir * move_speed
		
		move_and_slide()
	else:
		has_died.emit()

func _on_hurtbox_area_entered(area):
	
	if area.name == "Hitbox":
		
		healthbar.healthbar.value -= area.get_parent().damage
		health -= area.get_parent().damage

func get_node_type():
	return "player"
