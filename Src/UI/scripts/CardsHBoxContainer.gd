extends HBoxContainer

var card_list = []
# Called when the node enters the scene tree for the first time.
func _ready():
	var new_card_button = AssetsPreload.CARD_BUTTON_NODE.instantiate()
	add_child(new_card_button)
	new_card_button.message = "Test 1"
	new_card_button.console_print()
	new_card_button = AssetsPreload.CARD_BUTTON_NODE.instantiate()
	add_child(new_card_button)
	#new_card_button.position = Vector2(-50, -50)
	new_card_button.message = "Test 2"
	new_card_button.console_print()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


