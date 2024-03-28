extends Node3D

@onready var sturgeon = $Sturgeon
@onready var phantom_cameras = $PhantomCameras

func _ready():
	sturgeon.camera_activated.connect(phantom_cameras.enable_camera)
