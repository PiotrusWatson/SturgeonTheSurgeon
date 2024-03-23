extends Control

@onready var scene_changer = $scene_changer
@onready var dialogue_player = $DialoguePlayer

func _ready():
	dialogue_player.play_dialogue("intro")



func _on_dialogue_player_dialogue_finished(name):
	scene_changer.change_scene("main_menu")
