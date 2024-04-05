extends Object
class_name SpawningHelper

enum Directions {UP, FORWARD, RIGHT}
var stored_position: Vector3
var folder: Node
func _init(spawn_folder):
	folder = spawn_folder
	
func spawn_globally_at_point(thing_to_spawn: PackedScene, point = Vector3.ZERO):
	var spawned_thing = thing_to_spawn.instantiate()
	folder.add_child(spawned_thing)
	spawned_thing.global_position = point
	return spawned_thing

func spawn_next_to_last(thing_to_spawn: PackedScene, direction: Directions):
	var spawned_thing = spawn_globally_at_point(thing_to_spawn, stored_position)
	
func get_size_of_thing(spawned_thing: Node, direction: Directions):
	var mesh: MeshInstance3D = NodeUtils.get_child_of_type(spawned_thing, MeshInstance3D, false)
	mesh.
	
	
