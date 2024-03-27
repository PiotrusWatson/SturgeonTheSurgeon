extends RigidBody3D

@onready var rotator = $Rotator
@onready var timed_thruster = $TimedThruster
@onready var follow_camera_manager = $FollowCameraManager
@export var mouse_stick_dead_zone = 0.2
@export var follow_camera: PhantomCamera3D
@export var place_to_spawn_crosshair: Node
@export var crosshair_prefab: PackedScene

var crosshair: CrosshairPivot
var mouse_joystick: MouseJoystick
var spawning_helper: SpawningHelper
var rotation_direction = Vector2.ZERO
var is_swimming = false

var movement_inputs = ["Up", "Down", "Left", "Right"]
func _ready():
	#this lil code makes the internal code for getting the mouse's postion
	#update its maths when we change the size of the screen so it doesnt break :)
	var viewport_size = get_viewport().get_visible_rect().size
	get_tree().get_root().size_changed.connect(update_mouse_stick_bounds)
	mouse_joystick = MouseJoystick.new(viewport_size, mouse_stick_dead_zone)
	spawning_helper = SpawningHelper.new(place_to_spawn_crosshair)
	rotator._setup(self)
	timed_thruster._setup(self, self)
	follow_camera_manager._setup(follow_camera)
	
	crosshair = spawning_helper.spawn_globally_at_point(crosshair_prefab, global_position)
	crosshair.remote_path = get_path()
	#this timer is needed to make the follow camera not throw a hissy :)
	await get_tree().create_timer(0.1).timeout

func _process(delta):
	crosshair.rotate_in_direction(rotation_direction, delta)
	follow_camera_manager.rotate_to_follow_object(crosshair.crosshair_location)
	

func _physics_process(delta):
	rotator.rotate_towards(crosshair.crosshair_location)
	if is_swimming:
		timed_thruster.constant_thrust(delta)
	
#all the inputs are got here :)
func _unhandled_input(event):
	#either big thrust on release
	if event.is_action_released("Thrust"):
		timed_thruster.begin_thrust()
		is_swimming = false
	#or slow thrust on hold
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

