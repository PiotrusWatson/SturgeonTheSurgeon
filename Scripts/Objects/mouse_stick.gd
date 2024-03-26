extends Object

class_name MouseJoystick
var size: Vector2

var centre = Vector2(0.5, 0.5)
var dead_zone: float
var direction = Vector2.ZERO
func _init(viewport_size: Vector2, stick_dead_zone: float):
	size = viewport_size
	dead_zone = stick_dead_zone
	
func normalise_mouse_position(mouse_pos: Vector2) -> Vector2:
	return mouse_pos / size

func update_size(new_viewport_size: Vector2):
	size = new_viewport_size

func get_vector_from_centre(viewport_coordinate: Vector2) -> Vector2:
	return centre - viewport_coordinate
	
func get_new_direction(mouse_pos: Vector2) -> Vector2:
	var normalised_pos = normalise_mouse_position(mouse_pos)
	var new_direction = get_vector_from_centre(normalised_pos)
	return new_direction

func change_stick_direction(mouse_pos: Vector2):
	direction = get_new_direction(mouse_pos)

func get_direction() -> Vector2:
	return direction
