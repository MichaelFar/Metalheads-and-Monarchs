extends CharacterBody2D


@onready var ray_cast_2d = $RayCast2D
@export var move_speed = 300


func _process(delta):
	global_rotation = global_position.direction_to(get_global_mouse_position()).angle() + PI/2.0


func _physics_process(delta):
	var move_dir = Input.get_vector("Left", "Right", "Up", "Down")
	velocity = move_dir * move_speed
	move_and_slide()
