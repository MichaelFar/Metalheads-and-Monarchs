extends CharacterBody2D


@onready var ray_cast_2d = $RayCast2D
@export var move_speed = 300

@export var healthbar : Control
@export var health = 100
@export var graphics : Node2D

func _ready():
	healthbar.healthbar.value = health


func _physics_process(delta):
	var move_dir = Input.get_vector("Left", "Right", "Up", "Down")
	graphics.global_rotation = global_position.direction_to(get_global_mouse_position()).angle() + PI/2.0
	velocity = move_dir * move_speed
	move_and_slide()


func _on_hurtbox_area_entered(area):
	
	if area.name == "Hitbox":
		
		healthbar.healthbar.value -= area.get_parent().damage

