extends Node

class_name Cuttable

@export var mesh_folder: Node3D
var meshes = []


func _ready():
	refresh_meshes()

func refresh_meshes():
	for mesh in mesh_folder.get_children():
		meshes.append(mesh)

func replace_meshes(new_meshes):
	
	for mesh in new_meshes:
		pass
		
func get_closest_mesh_to_point(point: Vector3):
	var closest_distance = point.distance_to(meshes[0].global_position)
	var closest_mesh = meshes[0]
	for mesh in meshes:
		var distance = point.distance_to(meshes[0].global_position)
		if distance < closest_distance:
			closest_distance = distance
			closest_mesh = mesh
	return closest_mesh
		
		
