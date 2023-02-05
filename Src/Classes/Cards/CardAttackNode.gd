extends CardBase

class_name CardAttackNode

func cardEffect() -> void:
	print(getTitle());
	#TODO: Somehow make this effect stuff
	
func _init():
	title = "Attack"
	descrition = "Do attack"
