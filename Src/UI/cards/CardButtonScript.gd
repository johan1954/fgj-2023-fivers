extends Node

var message: String
var parent

func console_print():
	print(message)

func _pressed():
	print(message)
	#get_parent().remove_child(self)
