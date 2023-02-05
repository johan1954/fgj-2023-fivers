extends Node

class_name CardManager

var card_container = get_node("UI/CardContainer")

var base_cardpack : Array[CardBase]
var timer : float = 0

var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	base_cardpack.append(CardRemoveFungus.new())
	pass # Replace with function body.

func create_cards_from_pack(amount : int):
	var card = base_cardpack.pick_random()
	card_container.new_button(card)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	timer += delta
	
	if (timer >= GameEngine.DRAFT_TIMER):
		create_cards_from_pack(3)
		timer = timer - GameEngine.DRAFT_TIMER
	
	pass
