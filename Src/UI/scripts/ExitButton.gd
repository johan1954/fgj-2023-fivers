extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	connect("pressed",Callable(self,"_button_pressed"))

func _button_pressed():
	alert( "Kiitos ohjelman käytöstä!", "Ohjelmoinnin perusteet")
	await get_tree().create_timer(2.0).timeout
	print("Kiitos ohjelman käytöstä!")
	get_tree().quit()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func alert(alert_text: String, title: String='Message') -> void:
	var dialog = AcceptDialog.new()
	dialog.dialog_text = alert_text
	dialog.title = title
	dialog.ok_button_text = "Ole hyvä!"
	dialog.set_script(load("res://Src/UI/scripts/exitGameAcceptDialog.gd"))
	dialog.connect("confirmed", Callable(dialog,'_on_cancel_btn_is_pressed'))
	add_child(dialog,true)
	dialog.popup_centered()
	

	
