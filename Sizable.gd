extends Node

#Base class for sizable objects
class_name Sizable

@export var current_size = 1
@export var offset_sprite = Vector2 (0,0)

var sizableLine : Line2D
var sprite : Sprite2D

func _ready() -> void:
	sizableLine = get_node("Line2D")
	sprite = get_node("Sprite")
	add_size(0)

#Base for adding size to the object
func add_size(addition):
	current_size += addition
