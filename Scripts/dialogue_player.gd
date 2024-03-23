extends Node
class_name DialoguePlayer

signal dialogue_finished(name)

var dialogues = {
	"intro": load("res://Dialogue/intro.dialogue")
}

func play_dialogue(name):
	DialogueManager.show_dialogue_balloon(dialogues[name])
	await DialogueManager.dialogue_ended
	dialogue_finished.emit(name)
