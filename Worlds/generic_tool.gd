extends RigidBody3D
class_name Tool

@onready var attacher = $Attacher
func _ready():
	attacher._setup(self)	
	
func attach(other: Node3D):
	attacher.attach(other)
func detach():
	attacher.detach()
