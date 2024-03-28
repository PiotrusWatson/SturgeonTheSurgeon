extends RigidBody3D


@onready var attacher = $Attacher
func _ready():
	attacher._setup(self)	
	
func attach(other: RigidBody3D):
	attacher.attach(other)
