extends RemoteTransform3D
class_name CrosshairPivot

@onready var crosshair_location = $Crosshair
@onready var rotator = $Rotator

var node_to_follow

func _ready():
	rotator._setup(self)
	node_to_follow = get_node(remote_path)
	

func _process(delta):
	global_position = node_to_follow.global_position
	
	
func rotate_in_direction(direction, delta):
	rotator.rotate_in_direction(direction, delta)


func _on_rotator_rotated(amount):
	pass # Replace with function body.
