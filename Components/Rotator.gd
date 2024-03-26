extends Node3D

@export var rotation_speed = 1.0
@onready var crosshair_location = $Crosshair
var rotation_x = 0
var rotation_y = 0
const RIGHT_ANGLE_RADIANS = 1.5708
var body: Node3D

signal rotated(amount: Vector2)
func _setup(thing_to_rotate = self):
	body = thing_to_rotate
	top_level = true

func rotate_in_direction(direction: Vector2, delta = 1):
	var x_direction = direction.x * rotation_speed * delta
	direction.x *= -1
	rotation_x += x_direction
	
	var y_direction = -direction.y * rotation_speed * delta
	#clamp to make sure we don't go too high up or down??
	if abs(rotation_y + y_direction) > RIGHT_ANGLE_RADIANS:
		y_direction = 0
	rotation_y += y_direction
	
	rotate_y(x_direction)
	rotate_x(y_direction)
	rotated.emit(direction * rotation_speed * delta)
