extends GenericTool

@onready var pickup_manager = $PickupManager

func use():
	pickup_manager.try_pick_up()

func alt_use():
	pickup_manager.drop()
