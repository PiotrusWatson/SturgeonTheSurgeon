extends Node

var scenes = {"menu" : load("res://Worlds/main_menu.tscn"),
"placeholder_world": load("res://Worlds/placeholder_world.tscn")
}


func switch_scene(name):
	var new_scene = scenes[name]
	var current_scene = get_tree().current_scene
	get_tree().change_scene_to_packed(new_scene)



func _on_play_button_pressed():
	switch_scene("placeholder_world")
