extends TextureButton

class_name CardButton

var card_object : CardBase
var card_manager : CardManager


func _on_pressed():
	card_manager.handle_button_press(self, card_object)
