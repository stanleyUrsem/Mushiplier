extends Node2D

var sizeIncreaser

func _ready() -> void:
	print(self.name)
	#print(a.name)
	sizeIncreaser = get_node("SizeIncreaser")

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			sizeIncreaser.increase_size()
