extends Node3D
class_name Rotator

@export var rotation_speed = 1.0

var rotation_x = 0
var rotation_y = 0
const RIGHT_ANGLE_RADIANS = 1.5708
var body: Node3D

signal rotated(amount: Vector2)


func _setup(thing_to_rotate):
	body = thing_to_rotate

func rotate_towards(target: Node3D):
	body.look_at(target.global_position)

#copied from godot website :)
func rotate_towards_physics(state: PhysicsDirectBodyState3D, current_transform: Transform3D, target_position: Vector3) -> void:
	var forward_local_axis: Vector3 = Vector3(1, 0, 0)
	var forward_dir: Vector3 = (current_transform.basis * forward_local_axis).normalized()
	var target_dir: Vector3 = (target_position - current_transform.origin).normalized()
	var local_speed: float = clampf(rotation_speed, 0, acos(forward_dir.dot(target_dir)))
	if forward_dir.dot(target_dir) > 1e-4:
		state.angular_velocity = local_speed * forward_dir.cross(target_dir) / state.step

func rotate_in_direction(direction: Vector2, delta = 1):
	var x_direction = direction.x * rotation_speed * delta
	direction.x *= -1
	rotation_x += x_direction
	
	var y_direction = -direction.y * rotation_speed * delta
	rotation_y += y_direction
	
	body.rotate_y(x_direction)
	body.rotate_x(y_direction)
	rotated.emit(direction * rotation_speed * delta)
