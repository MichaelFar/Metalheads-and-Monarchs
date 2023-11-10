extends Area2D

@export var spawnCircle : CollisionShape2D
@export var enemyPreloader : ResourcePreloader
# Called when the node enters the scene tree for the first time.
var spawn_magnitude = 0.0 #Magnitude of the spawn point vector
var spawn_direction = Vector2.ZERO
var enemy_list = []
var spawnMin = 1
var spawnMax = 5
var healthMod = 0.0

func _ready():
	enemy_list = enemyPreloader.get_resource_list()
	get_viewport().size_changed.connect(update_spawn_circle)
	Globals.spawner = self
	update_spawn_circle()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_released("spawn"):
		spawn_enemies()


func update_spawn_circle():
	
	var viewportRect = get_viewport_rect()
	var viewportRadius = 0.0
	viewportRadius = viewportRect.size.x if viewportRect.size.x > viewportRect.size.y else viewportRect.size.y
	spawnCircle.shape.radius = viewportRadius / 1.5
	spawn_magnitude = spawnCircle.shape.radius
	
func spawn_enemies():
	var randObj = RandomNumberGenerator.new()
	if(Globals.activeEnemies.size() < 30):
		for i in enemy_list:
			
			var resource = enemyPreloader.get_resource(i)
			var amount = randObj.randi_range(spawnMin, spawnMax)
			
			for j in amount:
				
				var randx = randObj.randf_range(-1.0,1.0)
				var randy = randObj.randf_range(-1.0,1.0)
				var direction = Vector2(randx,randy).normalized()
				var enemy = resource.instantiate()
				Globals.currentLevel.add_child(enemy)
				enemy.global_position = (spawn_magnitude * direction ) + global_position
				enemy.health += healthMod
				
		
