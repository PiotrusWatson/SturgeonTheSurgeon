extends RigidBody3D

@onready var mover = $Mover
@export var is_mouse_keyboard = true
@export var mouse_stick_dead_zone = 0.2
var mouse_joystick: MouseJoystick
var rotation_direction = Vector2.ZERO
func _ready():
	var viewport_size = get_viewport().get_visible_rect().size
	get_tree().get_root().size_changed.connect(update_mouse_stick_bounds)
	 
	mouse_joystick = MouseJoystick.new(viewport_size, mouse_stick_dead_zone)
	mover._setup(self)
	

func _unhandled_input(event):
	if is_mouse_keyboard:
		handle_mouse_input(event)
	else:
		pass

func handle_mouse_input(event):
	if event is InputEventMouseMotion:
		mover.rotate_in_direction(event.relative)
		

func update_mouse_stick_bounds():
	var viewport_size = get_viewport().get_visible_rect().size
	mouse_joystick.update_size(viewport_size)
	
