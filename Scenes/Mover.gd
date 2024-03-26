extends Node
class_name Mover

var rigidbody: RigidBody3D
@export var speed = 5.0
@export var rotation_speed = 20
var rotation_x = 0
var rotation_y = 0

signal rotated(amount: Vector2)

func _setup(body: RigidBody3D):
	rigidbody = body
	
func move(desired_direction: Vector3):
	rigidbody.apply_central_force(desired_direction * speed)

func rotate_towards(target: Vector3):
	rigidbody.look_at(target)

func rotate_in_direction(direction: Vector2, delta = 1):
	var x_direction = direction.x * rotation_speed * delta
	direction.x *= -1
	rotation_x += x_direction
	
	var y_direction = -direction.y * rotation_speed * delta
	#clamp to make sure we don't go too high up or down??
	if abs(rotation_y + y_direction) > 1.5708:
		y_direction = 0
	rotation_y += y_direction
	
	rigidbody.rotate_y(x_direction)
	rigidbody.rotate_x(y_direction)
	rotated.emit(direction * rotation_speed * delta)


