extends Node

var message: String

func console_print():
	print(message)

func _pressed():
	print(message)
	remove_child()
