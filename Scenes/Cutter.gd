extends RayCast3D

var mesh_slicer: MeshSlicer
var current_mesh
func _ready():
	mesh_slicer = MeshSlicer.new()
	enabled = false
	
func try_get_mesh():
	enabled = true
	force_raycast_update()
	var collider = get_collider()
	if collider != null and collider.has_method("get_mesh"):
		current_mesh = collider.get_mesh()
		return true
	return false
		
func cut_mesh(mesh):
	return mesh_slicer.slice_mesh(transform, mesh)
	
