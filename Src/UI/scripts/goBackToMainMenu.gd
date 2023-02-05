extends Button

func _ready():
	connect("pressed",Callable(self,"_on_Button_Pressed"))
	#In the beginning the settings menu is hidden
	var ControlForSettingsMenu_node = get_node("/root/Node2D/ControlForSettingsMenu")
	print(ControlForSettingsMenu_node)
	ControlForSettingsMenu_node.visible = !ControlForSettingsMenu_node.visible
	
func _on_Button_Pressed():
	#Go back to the main menu by hiding the settings menu
	var ControlForMainMenuUI_node = get_node("/root/Node2D/ControlForMainMenuUI")
	ControlForMainMenuUI_node.visible = !ControlForMainMenuUI_node.visible
	
	#Hide the settings menu part
	var ControlForSettingsMenu_node = get_node("/root/Node2D/ControlForSettingsMenu")
	ControlForSettingsMenu_node.visible = !ControlForSettingsMenu_node.visible
	
