extends CanvasLayer

@onready var pickup_prompt = $PickupPrompt

func show_prompt():
	pickup_prompt.visible = true

func hide_prompt():
	pickup_prompt.visible = false
