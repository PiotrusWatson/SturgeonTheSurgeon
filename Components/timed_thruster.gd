extends Timer
class_name TimedThruster

@onready var cooldown_timer = $Cooldown
var rigidbody: RigidBody3D
var forward
var can_thrust = true
@export var thrust_strength = 20.0
@export var constant_thrust_strength = 100.0
func _setup(body: RigidBody3D, forward_transform):
	rigidbody = body
	forward = forward_transform
func thrust():
	rigidbody.apply_central_impulse(-forward.basis.z * thrust_strength)
	
func constant_thrust(delta):
	rigidbody.apply_central_force(-forward.basis.z * constant_thrust_strength * delta)

func begin_thrust():
	if !can_thrust:
		return
	start()
	cooldown_timer.start()
	can_thrust = false
	

func _on_timeout():
	thrust()


func _on_cooldown_timeout():
	can_thrust = true
