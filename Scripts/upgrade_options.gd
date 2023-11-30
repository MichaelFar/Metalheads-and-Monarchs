extends VBoxContainer

var upgradeScene = null
@export var upgradeLoader : ResourcePreloader
@export var button : Button
var loadedUpgradeScene = null
signal chosen_upgrade
# Called when the node enters the scene tree for the first time.
func _ready():
	
	name = "UpgradeOptions"
	upgradeScene = upgradeLoader.get_resource_list()[0]
	loadedUpgradeScene = upgradeLoader.get_resource(upgradeScene)
	resize()
	get_parent().resized.connect(resize)

func resize():
	
	size = Vector2(get_parent().size.x, 75.0)


func _on_button_button_up():
	chosen_upgrade.emit(upgradeScene,loadedUpgradeScene)
