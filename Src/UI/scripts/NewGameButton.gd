
extends Button

@export var reference_path = "res://kohtaus.tscn"
@export var start_focused: bool = false

func _ready():
	if(start_focused):
		grab_focus()
		
	connect("mouse_entered",Callable(self,"_on_Button_mouse_entered"))
	connect("pressed",Callable(self,"_on_Button_Pressed"))

func _on_Button_mouse_entered():
	grab_focus()

func _on_Button_Pressed():
	if(reference_path != ""):
		get_tree().change_scene_to_file(reference_path)
	else:
		get_tree().quit()


