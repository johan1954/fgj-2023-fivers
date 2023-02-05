extends Node

class_name CardManager

var card_container: CardButtonManager

var base_cardpack : Array[CardBase]
var active_cardpack : Array[CardBase]
var pending_card : CardBase
var pending_card_button : CardButton
var timer : float = 0

var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	card_container = get_node("/root/Scene/UI/CardContainer")
	base_cardpack.append(CardNeutralizeNode.new())
	pass # Replace with function body.

func create_cards_from_pack(amount : int):
	if base_cardpack.size() == 0:
		return
	var card = base_cardpack.pick_random()
	base_cardpack.erase(card)
	active_cardpack.append(card)
	card_container.new_button(card, self)

func handle_button_press(card_button: CardButton, card : CardBase):
	if card is CardAddAttack1:
		card.card_effect()
		card_container.remove_button(card_button)
	elif card is CardNeutralizeNode:
		pending_card = card
		pending_card_button = card_button
		
func handle_node_press(node: MapNode):
	if pending_card == null:
		return
	pending_card.card_effect(node)
	card_container.remove_button(pending_card_button)
	pending_card = null
	pending_card_button = null
		
func reset_card(card):
	active_cardpack.erase(card)
	base_cardpack.append(card)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if base_cardpack.size() == 0:
		timer = 0
		return
	
	for card in active_cardpack:
		card._process(delta)
	
	timer += delta
	
	if (timer >= GameEngine.DRAFT_TIMER):
		create_cards_from_pack(3)
		timer = timer - GameEngine.DRAFT_TIMER
	
	pass
