extends CharacterBody2D

var children = []
var frame = 1

@export var weapon_switcher : Node2D
@export var cooldown_timer : Timer
@export var animation_player : AnimationPlayer
@export var gun_offset : Marker2D

func _ready():
	children = get_children()
	hide_non_selected_children(0, Vector2(0, 10))
	weapon_switcher.shooting.connect(shoot)
	weapon_switcher.switched_weapon.connect(hide_non_selected_children)

func hide_non_selected_children(index, offset):
	
	for i in children:
		if('Monarch' in i.name):
			if(index == children.find(i)):
				
				i.visible = true
			else:
				
				i.visible = false

func shoot(speedScale):
	animation_player.speed_scale = 1.0 / speedScale
	print("Speed scale is " + str(speedScale))
	animation_player.play("shoot")
