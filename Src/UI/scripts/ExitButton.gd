extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	connect("pressed", self, "_button_pressed")

func _button_pressed():
	alert("T: Ohjelmoinnin perusteet", "Kiitos ohjelman käytöstä!")
	yield(get_tree().create_timer(2.0), "timeout")
	print("Kiitos ohjelman käytöstä!")
	get_tree().quit()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func alert(text: String, title: String='Message') -> void:
	var dialog = AcceptDialog.new()
	dialog.dialog_text = text
	dialog.window_title = title
	dialog.connect('modal_closed', dialog, 'queue_free')
	add_child(dialog)
	dialog.popup_centered()
