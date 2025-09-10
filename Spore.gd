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

var damping
var gravityAccel
var fadespeed 
func _ready() -> void:
	rng = RandomNumberGenerator.new()
	time = rng.randf()
	
func setup():
	time = rng.randf()
	amplitude = 1.0 + time
	direction.x *= -1.0 if rng.randf() > 0.5 else 1.0 
	damping = rng.randf_range(damping_range.x,damping_range.y)
	gravityAccel = rng.randf_range(gravityAccel_range.x,gravityAccel_range.y)
	fadespeed = 10.0

func _process(delta: float) -> void:
	if(visible == false):
		return
		
	time += delta * speed
	
	if position.y > get_window().size.y - lowest_y:
		fade_out(delta)
		return
	
	sway(delta)

func sway(delta):
	# side sway with damping
	amplitude = lerp(amplitude, 0.0, delta * damping)
	velocity.x = cos(time) * amplitude * direction.x
	 # falling velocity gradually increasing
	velocity.y = lerp(velocity.y, 1.0, delta * gravityAccel) * direction.y
	
	position += velocity
	rotation = lerp_angle(rotation,velocity.angle(),delta * speed)

func fade_out(delta):
	velocity.x = sin(time * lerp(fadespeed,50.0,delta * 5)) * .2
	velocity.y = delta * .5
	position += velocity
