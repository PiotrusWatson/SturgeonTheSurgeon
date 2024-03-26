extends Object
class_name SpawningHelper

var root: Window
func _init(scene_root):
	root = scene_root
	
func spawn_globally_at_point(thing_to_spawn: PackedScene, point = Vector3.ZERO):
	var spawned_thing = thing_to_spawn.instantiate()
	root.add_child(spawned_thing)
	spawned_thing.global_position = point
	return spawned_thing
	
