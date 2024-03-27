extends Node
class_name SceneChanger

var scenes = {
	"intro": load("res://Worlds/intro_dialogue.tscn"),
	"main_menu" : load("res://Worlds/main_menu.tscn"),
	"placeholder_world": load("res://Worlds/placeholder_world.tscn")
}


func change_scene(name):
	var new_scene = scenes[name]
	var current_scene = get_tree().current_scene
	get_tree().change_scene_to_packed(new_scene)



func _on_play_button_pressed():
	change_scene("placeholder_world")
