extends Node3D
class_name Rotator

@export var rotation_speed = 1.0

var rotation_x = 0
var rotation_y = 0
const RIGHT_ANGLE_RADIANS = 1.5708
var body: Node3D

signal rotated(amount: Vector2)


func _setup(thing_to_rotate):
	body = thing_to_rotate

func rotate_towards(target: Node3D):
	body.look_at(target.global_position)

func rotate_in_direction(direction: Vector2, delta = 1):
	var x_direction = direction.x * rotation_speed * delta
	direction.x *= -1
	rotation_x += x_direction
	
	var y_direction = -direction.y * rotation_speed * delta
	#clamp to make sure we don't go too high up or down??
	if abs(rotation_y + y_direction) > RIGHT_ANGLE_RADIANS:
		y_direction = 0
	rotation_y += y_direction
	
	body.rotate_y(x_direction)
	body.rotate_x(y_direction)
	rotated.emit(direction * rotation_speed * delta)
