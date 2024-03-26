extends RigidBody3D

@onready var mover = $Mover
@onready var timed_thruster = $TimedThruster
@onready var follow_camera_manager = $FollowCameraManager
@export var mouse_stick_dead_zone = 0.2
@export var follow_camera: PhantomCamera3D
var is_swimming = false
var mouse_joystick: MouseJoystick
var rotation_direction = Vector2.ZERO

var movement_inputs = ["Up", "Down", "Left", "Right"]
func _ready():
	var viewport_size = get_viewport().get_visible_rect().size
	get_tree().get_root().size_changed.connect(update_mouse_stick_bounds)
	 
	mouse_joystick = MouseJoystick.new(viewport_size, mouse_stick_dead_zone)
	mover._setup(self)
	timed_thruster._setup(self, self)
	follow_camera_manager._setup(follow_camera)

func _physics_process(delta):
	mover.rotate_in_direction(rotation_direction, delta)
	if is_swimming:
		timed_thruster.constant_thrust(delta)
	
func _unhandled_input(event):
	if event.is_action_released("Thrust"):
		timed_thruster.begin_thrust()
		is_swimming = false
	elif event.is_action_pressed("Thrust"):
		is_swimming = true
	
	if event is InputEventMouseMotion:
		mouse_joystick.change_stick_direction(event.position)
		rotation_direction = mouse_joystick.get_direction()
	elif is_movement_action_pressed(event):
		var horizontal = Input.get_axis("Right", "Left")
		var vertical = Input.get_axis("Down", "Up")
		rotation_direction = Vector2(horizontal, vertical)
	
func is_movement_action_pressed(event) -> bool:
	for input_string in movement_inputs:
		if event.is_action_pressed(input_string):
			return true
	return false

func update_mouse_stick_bounds():
	var viewport_size = get_viewport().get_visible_rect().size
	mouse_joystick.update_size(viewport_size)

func _on_mover_rotated(amount):
	follow_camera_manager.rotate_camera(amount)
