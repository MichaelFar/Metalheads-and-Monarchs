extends Node2D


# Called when the node enters the scene tree for the first time.



func _on_child_entered_tree(node):
	Globals.player.graphics.material = node.material
	Globals.player.graphics.material.set_shader_parameter("applied", true)
	print("Setting player shader")


func _on_child_exiting_tree(node):
	Globals.player.graphics.material.set_shader_parameter("applied", false)
