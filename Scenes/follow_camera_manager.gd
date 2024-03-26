extends Node
class_name FollowCameraManager
var follow_camera: PhantomCamera3D
@export var damping_amount = 1.0
func _setup(camera: PhantomCamera3D):
	follow_camera = camera

func damp() -> float:
	return 1 / damping_amount

func rotate_camera(amount):
	var camera_rotation = follow_camera.get_third_person_rotation()
	camera_rotation.x -= amount.y * damp()
	camera_rotation.y -= amount.x * damp()
	follow_camera.set_third_person_rotation(camera_rotation)
