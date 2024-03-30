extends RayCast3D
class_name PickupManager

var holding_something = false
var can_hold_something = false
var held_thing : RigidBody3D

func _physics_process(delta):
	
	if holding_something:
		held_thing.global_position = global_position
		held_thing.global_rotation = global_rotation
		
func pick_up(other_object):
	held_thing = other_object
	held_thing.freeze = true
	holding_something = true
	
func drop():
	if !holding_something:
		return
	holding_something = false
	held_thing.freeze = false
	held_thing = null
	
func try_pick_up():
	enabled = true
	force_raycast_update()
	var collider = get_collider()
	if is_valid(collider):
		pick_up(collider)
		return true
	return false

func is_valid(collider):
	return !holding_something and collider is RigidBody3D
	
