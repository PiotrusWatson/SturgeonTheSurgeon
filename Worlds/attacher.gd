extends Node
class_name Attacher

@export var rotation_offset = Vector3(90, 0, 0)
var rigidbody: RigidBody3D
var target_point: Node3D
var is_attached = false
func _setup(body: RigidBody3D):
	rigidbody = body

func _physics_process(delta):
	if is_attached:
		rigidbody.global_position = target_point.global_position
		rigidbody.global_rotation = target_point.global_rotation + rotation_offset

func attach(other_point: Node3D):
	rigidbody.freeze = true
	is_attached = true
	target_point = other_point

func detach():
	is_attached = false
	rigidbody.freeze = false

