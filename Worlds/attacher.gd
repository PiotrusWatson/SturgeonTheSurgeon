extends JoltGeneric6DOFJoint3D
class_name Attacher

var rigidbody: RigidBody3D
var layer
func _setup(body: RigidBody3D):
	rigidbody = body
	layer = rigidbody.collision_layer
	toggle_angular_limit(false)
	toggle_linear_limit(false)

func attach(other: RigidBody3D):
	node_b = other.get_path()
	toggle_linear_limit(true)
	toggle_angular_limit(true)
	
	
func toggle_linear_limit(is_on: bool):
	set("linear_limit_x/enabled", is_on)
	set("linear_limit_y/enabled", is_on)
	set("linear_limit_z/enabled", is_on)
	
func toggle_angular_limit(is_on: bool):
	set("angular_limit_x/enabled", is_on)
	set("angular_limit_y/enabled", is_on)
	set("angular_limit_z/enabled", is_on)
	
func toggle_linear_spring(is_on: bool):
	set("linear_spring_x/enabled", is_on)
	set("linear_spring_y/enabled", is_on)
	set("linear_spring_z/enabled", is_on)

func detach():
	node_b = NodePath()

