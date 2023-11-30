extends CharacterBody2D

var playerNode = null

@export var acceleration = 600.0
@export var max_speed = 450.0
@export var damage = 10
@export var RayCastContainer : CharacterBody2D
@export var raycast = true
@export var sprite : Sprite2D
@export var health = 25.0
@export var healthbar : ProgressBar
@export var animationPlayer : AnimationPlayer
@export var ShaderLoader : ResourcePreloader
@export var SpriteLoader : ResourcePreloader

var blood_particles = preload("res://Scenes/blood_particles.tscn")

var shaderList = []

var KBFrames = 0
var KBApplied = false
var frame = 0
var shouldStop = false
# Called when the node enters the scene tree for the first time.
func _ready():
	playerNode = Globals.player
	
	Globals.game_timer.game_complete.connect(freeze)
	Globals.activeEnemies.append(self)
	shaderList = ShaderLoader.get_resource_list()
	randomize_sprite()
	random_speed()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	frame += 1
	if(frame == 1):
		animationPlayer.play("walk")
		healthbar.value = health
		healthbar.max_value = health
	if(health <= 0.0):
		Globals.game_timer.totalEnemiesDefeated += 1
		Globals.activeEnemies.pop_at(Globals.activeEnemies.find(self))
		queue_free()
	if(!shouldStop):
		
		var destination = playerNode.global_position - global_position 
		
		destination = destination.normalized()
		
		if(raycast):
			RayCastContainer.supplied_direction = destination
			
			destination = RayCastContainer.suggestedVector
		
		sprite.look_at(playerNode.global_position)
		KBFrames += 1
		
		if(!KBApplied):
	
			velocity = velocity.move_toward(destination * max_speed, delta * acceleration)
		else:
			
			if(KBFrames / 5 == 1):
				KBApplied = false
				
				
		if(KBFrames / 15 == 1):
			
			material.set_shader_parameter("applied", false)
			
		move_and_slide()



func _on_hurtbox_area_entered(area):
	if(area.name == "Hitbox" && !area.owner.has_method("get_node_type")):
		var blood_particles_scene = blood_particles.instantiate()
		add_child(blood_particles_scene)
		var destination = playerNode.global_position - global_position
		destination = destination.normalized()
		var hasKB = area.get_parent().has_KB
		
		health -= area.get_parent().damage
		
		healthbar.value = health
		if(health <= 0.0 && area.get_parent() == Globals.melee):
			Globals.player.health += 25.0
			Globals.player.healthbar.healthbar.value = Globals.player.health
		
		velocity = -1.0 * destination * (max_speed * area.get_parent().KBStrength / 3.0) if hasKB else velocity
		blood_particles_scene.process_material.direction = Vector3(velocity.x, velocity.y, 0)
		set_shader_time()
		material.set_shader_parameter("applied", true)
		KBFrames = 0
		KBApplied = true
		blood_particles_scene.emitting = true
		
		
func get_node_type():
	return "enemy"
	
func random_speed():
	var randObj = RandomNumberGenerator.new()
	max_speed = randObj.randf_range(max_speed - 100.0, max_speed + 200.0)
	
func freeze():
	shouldStop = true

func set_shader_time():
	
	material.set_shader_parameter("start_time", Time.get_ticks_msec() / 1000.0)#Give time in seconds since engine has started

func randomize_sprite():
	var randOBJ = RandomNumberGenerator.new()
	var randIndex = randOBJ.randi_range(0, SpriteLoader.get_resource_list().size() - 1)
	var selectedSprite = SpriteLoader.get_resource(SpriteLoader.get_resource_list()[randIndex])
	sprite.texture = selectedSprite
