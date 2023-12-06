extends Control
@export var planet: AnimationPlayer

func _ready():
	planet.play("Planet")
