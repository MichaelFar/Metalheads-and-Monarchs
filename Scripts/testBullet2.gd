extends bullet

class_name testBullet2

func _ready():
	initialize()

func _physics_process(delta):
	queue_free()

func area_detection(area):

	queue_free()
