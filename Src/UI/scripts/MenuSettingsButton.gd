
extends Button

func _ready():
	connect("pressed",Callable(self,"_on_Button_Pressed"))

func _on_Button_Pressed():
	#Hide the main menu
	var ControlForMainMenuUI_node = get_node("/root/Node2D/ControlForMainMenuUI")
	ControlForMainMenuUI_node.visible = !ControlForMainMenuUI_node.visible
	
	#Show the settings menu
	var ControlForSettingsMenu_node = get_node("/root/Node2D/ControlForSettingsMenu")
	ControlForSettingsMenu_node.visible = !ControlForSettingsMenu_node.visible
	



