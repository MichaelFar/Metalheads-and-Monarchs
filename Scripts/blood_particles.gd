extends GPUParticles2D

var frame = 0.0
# Called when the node enters the scene tree for the first time.


func _process(delta):
	frame += 1.0
	if(frame >= ((1/delta) / 3.0)):
		emitting = false
	if(frame >= (1/delta)):
		queue_free()
