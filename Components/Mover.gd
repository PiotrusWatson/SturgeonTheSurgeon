extends Node
class_name Mover

var rigidbody: RigidBody3D
@export var speed = 5.0
@export var rotation_speed = 20
var rotation_x = 0
var rotation_y = 0

func _setup(body: RigidBody3D):
	rigidbody = body
	
func move(desired_direction: Vector3):
	rigidbody.apply_central_force(desired_direction * speed)

func rotate_towards(target: Node3D):
	rigidbody.look_at(target.global_position)




