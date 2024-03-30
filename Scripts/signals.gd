extends Node3D

@onready var sturgeon = $Sturgeon
@onready var phantom_cameras = $PhantomCameras
@onready var ui = $UI

func _ready():
	sturgeon.camera_activated.connect(phantom_cameras.enable_camera)
	sturgeon.went_in_range_of_attachable.connect(ui.show_prompt)
	sturgeon.went_out_of_range_of_attachable.connect(ui.hide_prompt)
