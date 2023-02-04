extends BoxContainer

class_name CardButtonManager

var card_buttons: Array[CardButton] = []

func new_button():
	var new_card_button = AssetsPreload.CARD_BUTTON_NODE.instantiate()
	card_buttons.append(new_card_button)
	add_child(new_card_button)

# Called when the node enters the scene tree for the first time.
func _ready():
	new_button()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
