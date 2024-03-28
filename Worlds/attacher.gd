extends Generic6DOFJoint3D
class_name Attacher

var rigidbody: RigidBody3D

func _setup(body: RigidBody3D):
	rigidbody = body


func attach(other: RigidBody3D):
	#rigidbody.global_position = other.global_position
	#rigidbody.rotate_x(90)
	node_b = other.get_path()
	rigidbody.global_position = other.global_position
	
	
	

func detach():
	node_b = NodePath()

