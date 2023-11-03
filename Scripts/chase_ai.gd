extends CharacterBody2D

var playerNode = null

@export var acceleration = 600.0
@export var max_speed = 200.0
@export var damage = 10
@export var RayCastContainer : CharacterBody2D
@export var raycast = true
@export var sprite : Sprite2D
@export var health = 100.0
@export var healthbar : ProgressBar
@export var animationPlayer : AnimationPlayer

var frame = 0
var shouldStop = false
# Called when the node enters the scene tree for the first time.
func _ready():
	playerNode = Globals.player
	healthbar.value = health
	Globals.game_timer.game_complete.connect(freeze)
	Globals.activeEnemies.append(self)
	
	random_speed()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	frame += 1
	if(frame == 1):
		animationPlayer.play("walk")
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
		velocity = velocity.move_toward(destination * max_speed, delta * acceleration)
		move_and_slide()



func _on_hurtbox_area_entered(area):
	if(area.name == "Hitbox" && !area.owner.has_method("get_node_type")):
		
		print("Hit enemy")
		health -= area.get_parent().damage
		healthbar.value = health
		
		
func get_node_type():
	return "enemy"
	
func random_speed():
	var randObj = RandomNumberGenerator.new()
	max_speed = randObj.randf_range(max_speed - 100.0, max_speed + 200.0)
	
func freeze():
	shouldStop = true
