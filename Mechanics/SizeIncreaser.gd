extends Node2D

@export var size_increase = 1

#Size increaser -> increases size of whatever?
#This will increase anything by a size of a variable
#The to be increased in size needs to handle their own way of size increasing
func increase_size():
	var children = get_children(true)
	for i in range(children.size()):
		var sizableChild = children[i]
		if sizableChild is Sizable:
			sizableChild.add_size(size_increase)
	return
