extends Rotator
class_name CrosshairPivot

@onready var crosshair_location = $Crosshair

func _ready():
	_setup(self)
