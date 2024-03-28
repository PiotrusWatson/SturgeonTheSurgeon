extends Node
class_name PhantomCameraManager

var camera_dictionary = {}
func _ready():
	for child in get_children():
		if child is PhantomCamera3D:
			camera_dictionary[child.name] = child

func disable_all():
	for key in camera_dictionary:
		camera_dictionary[key].set_priority(0)

func enable_camera(name: String):
	disable_all()
	camera_dictionary[name].set_priority(1)
