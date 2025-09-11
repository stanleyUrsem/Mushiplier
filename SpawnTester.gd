extends Node2D

@export var spawnTest : StringName


var poolManager : PoolManager

func _ready() -> void:
	poolManager = get_node("PoolManager")

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		SignalHub.spawn.emit(spawnTest,event.position,poolManager)
