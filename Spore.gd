extends Poolable

@export var direction : Vector2
@export var speed : float
var velocity : Vector2
var time : float
var rng : RandomNumberGenerator
var amplitude : float
@export var damping_range : Vector2
@export var gravityAccel_range : Vector2
@export var lowest_y : float
@export var mushroom_chance : int

var damping
var gravityAccel
var fadespeed 
var poolManager 
var mushroomSpawner 

func _ready() -> void:
	rng = RandomNumberGenerator.new()
	time = rng.randf()
	poolManager = get_tree().current_scene.get_node("PoolManager")
	mushroomSpawner = get_tree().current_scene.get_node("MushroomSpawner")
	
func setup():
	time = rng.randf()
	amplitude = 1.0 + time
	direction.x *= -1.0 if rng.randf() > 0.5 else 1.0 
	damping = rng.randf_range(damping_range.x,damping_range.y)
	gravityAccel = rng.randf_range(gravityAccel_range.x,gravityAccel_range.y)
	fadespeed = 10.0
	skew = rng.randf_range(-90,90)
	modulate = Color.from_hsv(rng.randf_range(0.25,0.5),0.25,rng.randf_range(0.5,1.0))

func _process(delta: float) -> void:
	if(visible == false):
		return
		
	time += delta * speed
	
	if position.y >  - lowest_y:
		fade_out(delta)
		return
	
	sway(delta)

func sway(delta):
	# side sway with damping
	amplitude = lerp(amplitude, 0.0, delta * damping)
	velocity.x = cos(time) * amplitude * direction.x
	 # falling velocity gradually increasing
	velocity.y = lerp(velocity.y, 1.0, delta * gravityAccel) * direction.y
	modulate.a = amplitude
	position += velocity
	rotation = lerp_angle(rotation,velocity.angle(),delta * speed)

func fade_out(delta):
	velocity.x = sin(time * lerp(fadespeed,50.0,delta * 5)) * .2
	velocity.y = delta * .5
	position += velocity
	
	if position.y > lowest_y:
		var roll = rng.randi_range(0,100)
		if roll < mushroom_chance:
			SignalHub.spawn.emit("Mushroom",position,null)
		SignalHub.despawn.emit(self,"Spore")
		
