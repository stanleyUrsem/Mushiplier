extends Node2D

@export var spawnTest : PackedScene


var poolManager : PoolManager

func _ready() -> void:
	poolManager = get_node("PoolManager")

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		poolManager.spawn_at_position(spawnTest,event.position,poolManager)
