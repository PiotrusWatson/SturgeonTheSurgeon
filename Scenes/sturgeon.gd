extends RigidBody3D

@onready var rotator = $Rotator
@onready var timed_thruster = $TimedThruster
@onready var follow_camera_manager = $FollowCameraManager
@onready var mouth_point = $MouthPoint
@export var mouse_stick_dead_zone = 0.2
@export var follow_camera: PhantomCamera3D
@export var place_to_spawn_crosshair: Node
@export var crosshair_prefab: PackedScene
@export var mouse_sensitivity = 0.2
var crosshair: CrosshairPivot
var mouse_joystick: MouseJoystick
var spawning_helper: SpawningHelper
var rotation_direction = Vector2.ZERO
var is_swimming = false
var holding_item = false
var in_range_of_item = false
var item_i_could_hold
var held_item

var movement_inputs = ["Up", "Down", "Left", "Right"]

signal camera_activated(name)
signal went_in_range_of_attachable
signal went_out_of_range_of_attachable
func _ready():
	
	spawning_helper = SpawningHelper.new(place_to_spawn_crosshair)
	crosshair = spawning_helper.spawn_globally_at_point(crosshair_prefab, global_position)
	crosshair.remote_path = get_path()
	
	rotator._setup(self)
	timed_thruster._setup(self, self)
	follow_camera_manager._setup(follow_camera)
	#this timer is needed to make the follow camera not throw a hissy :)
	await get_tree().create_timer(0.1).timeout
	camera_activated.emit("CameraGuider")

func _process(delta):
	crosshair.rotate_in_direction(rotation_direction, delta)
	follow_camera_manager.rotate_to_follow_object(crosshair.crosshair_location)
	

func _physics_process(delta):
	rotator.rotate_towards(crosshair.crosshair_location)
	if is_swimming:
		timed_thruster.constant_thrust(delta)
	
#all the inputs are got here :)
func _unhandled_input(event):
	
	handle_mouse_mode(event)
	#either big thrust on release
	if event.is_action_released("Thrust"):
		timed_thruster.begin_thrust()
		is_swimming = false
	#or slow thrust on hold
	elif event.is_action_pressed("Thrust"):
		is_swimming = true
		
	if event.is_action_pressed("LookBack"):
		camera_activated.emit("ReverseCamera")
	elif event.is_action_released("LookBack"):
		camera_activated.emit("CameraGuider")
		
	if event.is_action_pressed("Hold") and can_hold():
		hold_item()
	elif event.is_action_released("Hold") and holding_item:
		drop_item()
		
	if event.is_action_pressed("Use") and holding_item:
		held_item.use()
	elif event.is_action_released("Use") and holding_item:
		held_item.alt_use()
		
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		#mouse_joystick.change_stick_direction(event.relative)
		rotation_direction = event.relative * mouse_sensitivity
	elif is_movement_action_pressed(event):
		var horizontal = Input.get_axis("Right", "Left")
		var vertical = Input.get_axis("Down", "Up")
		rotation_direction = Vector2(horizontal, vertical)
	
func is_movement_action_pressed(event) -> bool:
	for input_string in movement_inputs:
		if event.is_action_pressed(input_string):
			return true
	return false

func hold_item():
	item_i_could_hold.attach(mouth_point)
	held_item = item_i_could_hold
	holding_item = true

func drop_item():
	held_item.detach()
	held_item = null
	holding_item = false
	
func handle_mouse_mode(event: InputEvent):
	if Input.mouse_mode == Input.MOUSE_MODE_VISIBLE and event.is_action_pressed("click"):
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	elif event.is_action_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _on_mouth_body_entered(body):
	if body.has_method("attach") and !in_range_of_item:
		item_i_could_hold = body
		went_in_range_of_attachable.emit()
		in_range_of_item = true


func _on_mouth_radius_body_exited(body):
	if body.has_method("attach") and in_range_of_item:
		item_i_could_hold = null
		in_range_of_item = false
		went_out_of_range_of_attachable.emit()

func can_hold():
	return in_range_of_item and !holding_item
