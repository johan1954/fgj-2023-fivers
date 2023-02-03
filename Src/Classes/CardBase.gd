extends Node

class_name CardBase

var title: String
var speedIncrease: float

func cardEffect() -> void:
	print("Card effect, generic")

func getTitle() -> String:
	return title
