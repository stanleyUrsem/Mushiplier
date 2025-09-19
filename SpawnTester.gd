extends Node2D

@export var spawnTest : StringName


var poolManager : PoolManager
var camera : Camera2D	
func _ready() -> void:
	poolManager = get_node("PoolManager")
	camera = get_viewport().get_camera_2d()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		
		SignalHub.spawn.emit(spawnTest,get_global_mouse_position(),poolManager)
