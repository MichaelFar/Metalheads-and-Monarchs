extends Area2D

@export var true_name = 'powerup'
# Called when the node enters the scene tree for the first time.
@export var power_up_shape : CollisionShape2D
@export var powerup_timer : Timer#Don't delete this
@export var active_time = 10.0

var frame = 0.0

func _process(delta):
	frame += 1.0
	var frame_rate = 1.0/delta
	if frame / frame_rate >= active_time:
		frame = 0.0
		if(!visible):
			queue_free()
		

func _on_powerup_timer_timeout():
	if(!visible):
		queue_free()
	else:
		powerup_timer.start(10.0)


func _on_area_entered(area):
	
	if(area.name == "Hurtbox"):
		
		if(area.get_parent().has_method("get_node_type")):
			
			if(area.get_parent().get_node_type() == 'player'):
				frame = 0.0
				powerup_timer.start()
				reparent.call_deferred(Globals.weapon_changer.powerUpNodes)
				power_up_shape.set_disabled.call_deferred(true)
				hide()

