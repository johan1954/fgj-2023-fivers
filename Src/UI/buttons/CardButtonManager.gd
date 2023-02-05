extends BoxContainer

class_name CardButtonManager

var card_buttons: Array[CardButton] = []

func new_button(card : CardBase, card_manager : CardManager):
	var new_card_button = AssetsPreload.CARD_BUTTON_NODE.instantiate()
	new_card_button.card_object = card
	new_card_button.card_manager = card_manager
	card_buttons.append(new_card_button)
	add_child(new_card_button)
	
func remove_button(card_button: CardButton):
	card_buttons.erase(card_button)
	remove_child(card_button)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
