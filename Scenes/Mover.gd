extends Node
class_name Mover

var rigidbody: RigidBody3D
@export var speed = 5.0
@export var rotation_speed = 20

func _setup(body: RigidBody3D):
	rigidbody = body
	
func move(desired_direction: Vector3):
	rigidbody.apply_central_force(desired_direction * speed)

func rotate_towards(target: Vector3):
	rigidbody.look_at(target)

func rotate_in_direction(direction: Vector2):
	rigidbody.rotate_y(-direction.x * rotation_speed)
	rigidbody.rotate_x(-direction.y * rotation_speed)


