extends RigidBody3D


@onready var attacher = $Attacher
func _ready():
	attacher._setup(self)	
	
func attach(other: Node3D):
	attacher.attach(other)
