extends Node2D


var rng : RandomNumberGenerator

func _ready():
	rng = RandomNumberGenerator.new()

func spawn_at_position(chance,position):
	if rng.randf_range(0,100) > chance:
		SignalHub.spawn.emit("Mushroom",position,self)
