extends Sizable

#Adds size in a straight upwards way
func add_size(addition):
	super(addition)
	var new_pos = Vector2(0,current_size)
	sizableLine.points[1] = new_pos
	sprite.position = new_pos + offset_sprite
