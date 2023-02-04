
extends Button

func _ready():
	print("wtf")
	#var panel = get_node("/root/Node2D/ControlForMainMenuUI")
	#print(panel)
	#panel.visible = !panel.visible
	
	for _i in get_tree().get_root().get_children():
		print(_i)
	connect("pressed",Callable(self,"_on_Button_Pressed"))

func _on_Button_Pressed():
	#Hide the main menu
	var ControlForMainMenuUI_node = get_node("/root/Node2D/ControlForMainMenuUI")
	print(ControlForMainMenuUI_node)
	ControlForMainMenuUI_node.visible = !ControlForMainMenuUI_node.visible
	
	#Show the settings menu
	var ControlForSettingsMenu_node = get_node("/root/Node2D/ControlForSettingsMenu")
	print(ControlForSettingsMenu_node)
	ControlForSettingsMenu_node.visible = !ControlForSettingsMenu_node.visible
	
	print("No teeppä jottai")
	#get_tree().change_scene_to_file(reference_path)
	#$ControlForMainMenuUI.hide()



