extends Node
class_name Attacher

var rigidbody: RigidBody3D
var target_point: Node3D
var is_attached = false
func _setup(body: RigidBody3D):
	rigidbody = body

func _physics_process(delta):
	if is_attached:
		rigidbody.global_position = target_point.global_position
		rigidbody.global_rotation = target_point.global_rotation + Vector3(90, 0, 0)

func attach(other_point: Node3D):
	rigidbody.freeze = true
	is_attached = true
	target_point = other_point

func detach():
	is_attached = false
	rigidbody.freeze = false

