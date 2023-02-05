extends Node

#Needed for exit button AcceptDialog dialog.
func _on_cancel_btn_is_pressed():
		print("Olipa sulla kiire")
		get_tree().quit()
