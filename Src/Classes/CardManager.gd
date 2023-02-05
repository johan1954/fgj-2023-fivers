extends Node

class_name CardManager

var card_container: CardButtonManager

var base_cardpack : Array[CardBase]
var active_cardpack : Array[CardBase]
var timer : float = 0

var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	card_container = get_node("/root/Scene/UI/CardContainer")
	var card_add_attack = CardAddAttack1.new()
	card_add_attack.card_manager = self
	base_cardpack.append(card_add_attack)
	pass # Replace with function body.

func create_cards_from_pack(amount : int):
	if base_cardpack.size() == 0:
		return
	var card = base_cardpack.pick_random()
	base_cardpack.erase(card)
	active_cardpack.append(card)
	card_container.new_button(card, self)

func handle_button_press(card_button: CardButton, card : CardBase):
	card_container.remove_button(card_button)
	if card is CardAddAttack1:
		card.card_effect()
		
func reset_card(card):
	active_cardpack.erase(card)
	base_cardpack.append(card)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for card in active_cardpack:
		card._process(delta)
	
	timer += delta
	
	if (timer >= GameEngine.DRAFT_TIMER):
		create_cards_from_pack(3)
		timer = timer - GameEngine.DRAFT_TIMER
	
	pass
