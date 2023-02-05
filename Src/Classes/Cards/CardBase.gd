extends Node

class_name CardBase

var title: String
var descrition: String
# var card_power: int

func get_card_effect() -> void:
	print("Card effect, generic")

func getTitle() -> String:
	return title
	

