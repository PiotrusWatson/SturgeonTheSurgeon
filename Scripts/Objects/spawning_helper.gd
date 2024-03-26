extends Object
class_name SpawningHelper

var folder: Node
func _init(spawn_folder):
	folder = spawn_folder
	
func spawn_globally_at_point(thing_to_spawn: PackedScene, point = Vector3.ZERO):
	var spawned_thing = thing_to_spawn.instantiate()
	folder.add_child(spawned_thing)
	spawned_thing.global_position = point
	return spawned_thing
	
